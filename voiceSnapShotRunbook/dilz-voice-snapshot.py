try:
    from datetime import datetime, timedelta, timezone
    import automationassets
    from azure.identity import DefaultAzureCredential
    from azure.mgmt.compute import ComputeManagementClient
    from azure.mgmt.resource import ResourceManagementClient
    from msrestazure.azure_cloud import AZURE_US_GOV_CLOUD

    print('import(s) working ..\n')
except Exception as e:
    print(f'Importing error: {e}{repr(e)}')

try:
    sub_id = automationassets.get_automation_variable('AZURE_SUB_ID')
    snapshot_expire_in_days = automationassets.get_automation_variable('SNAP_EXPIRE_THRESHOLD')
except Exception as e:
    print(f'Variable import error: {e}{repr(e)}')


def list_vm_snapshots(sub_id):
    credential = DefaultAzureCredential(authority=AZURE_US_GOV_CLOUD.endpoints.active_directory)
    compute_client = ComputeManagementClient(
        credential,
        sub_id,
        base_url=AZURE_US_GOV_CLOUD.endpoints.resource_manager,
        credential_scopes=[AZURE_US_GOV_CLOUD.endpoints.resource_manager + '/.default']
    )
    resource_client = ResourceManagementClient(
        credential,
        sub_id,
        base_url=AZURE_US_GOV_CLOUD.endpoints.resource_manager,
        credential_scopes=[AZURE_US_GOV_CLOUD.endpoints.resource_manager + '/.default']
    )

    list_resource_groups = resource_client.resource_groups.list()

    for resource_group in list_resource_groups:
        snapshots = compute_client.snapshots.list_by_resource_group(resource_group.name)
        now_utc = datetime.now(timezone.utc)
        for snapshot in snapshots:
            snap_time_utc = snapshot.time_created.astimezone(timezone.utc)
            if now_utc - snap_time_utc > timedelta(days=snapshot_expire_in_days):
                delete_snap(compute_client, resource_group.name, snapshot.name)
            else:
                print(f'Snapshot not expired, skipping: {snapshot.name}. Snapshot age: {now_utc - snap_time_utc}')


def delete_snap(compute_client, resource_group_name, snapshot_name):
    compute_client.snapshots.begin_delete(resource_group_name, snapshot_name)
    print(f'Snapshot deleted: {snapshot_name}')


try:
    list_vm_snapshots(sub_id)
except Exception as e:
    print(f'{e}{repr(e)}')