try:
    import time
    import datetime
    import automationassets
    from azure.identity import DefaultAzureCredential
    from azure.mgmt.compute import ComputeManagementClient
    from msrestazure.azure_cloud import AZURE_US_GOV_CLOUD
    print('import(s) working ..\n')
except Exception as e:
    print(f'Importing error: {e}{repr(e)}')


try:
    sub_id = automationassets.get_automation_variable('AZURE_SUB_ID')
    rg_name = automationassets.get_automation_variable('VM_RG_NAME')
    vms_to_snap = automationassets.get_automation_variable('VM_NAMES')
except Exception as e:
    print(f'Variable import error: {e}{repr(e)}')


try:
    vm_list = [vm.strip() for vm in vms_to_snap.split(',')]
except Exception as e:
    print(f'Vm list creation error: {e}{repr(e)}')


def take_vm_snapshot(sub_id, rg_name, vm_name, snapshot_name):
    # print(AZURE_US_GOV_CLOUD.endpoints.resource_manager)
    credential = DefaultAzureCredential(authority=AZURE_US_GOV_CLOUD.endpoints.active_directory)
    compute_client = ComputeManagementClient(
        credential,
        sub_id,
        base_url=AZURE_US_GOV_CLOUD.endpoints.resource_manager,
        credential_scopes=[AZURE_US_GOV_CLOUD.endpoints.resource_manager + "/.default"]
        )

    vm = compute_client.virtual_machines.get(rg_name, vm_name)

    snapshot_properties = {
        'location': vm.location,
        'creation_data': {
            'create_option': 'Copy',
            'source_uri': vm.storage_profile.os_disk.managed_disk.id
        }
    }
    snapshot_async_operation = compute_client.snapshots.begin_create_or_update(
        rg_name,
        snapshot_name,
        snapshot_properties
    )
    snapshot_result = snapshot_async_operation.result()
    print("Snapshot created: ", snapshot_result.name)


time_now = datetime.datetime.now()
time_format = time_now.strftime('%m-%d-%Y_%H-%M-%S')


try:
    for vm in vm_list:
        snapshot_name = f'{vm}-{time_format}_snap'
        take_vm_snapshot(sub_id, rg_name, vm, snapshot_name)
except Exception as e:
    print(f'Snapshot error: {e}{repr(e)}')