# Runbooks for automated snapshot creation & expiration 

* Currently only scoped to run on azure gov

#### Requirements:
* Azure automation account
* Managed Identity
* Python = 3.8 > 
* Associated python libraries

###### ToDo's :
* Use different method to capture vm names for snapshot creation, currently using an env. variable

#### What does it do?:
Creates two python runbooks under an automation account
Takes scheduled snapshots of named vm's<br>
Expires/removes all snapshots in subscription after set threshold

#### Getting started:
* Clone this repo./copy to your environment<br>
* Change directory to IaC
* Copy terraform.tfvars.template to terraform.tfvars
* Edit terraform.tfvars file to suit your environment, required values are:
  * subscription_id
  * resource_group_name
  * resource_group_location
  * automation_account_name
* Authenticate and kick off the terraform build e.g.: terraform init/plan/apply 
* Assign the automationAccount's managed identity to the vms resource group roles (via IAM) : "Virtual Machine Contributor", 
  "Disk Snapshot Contributor" .
* Add your vm names that you wish to snap, this is set with the automation account variable: "VM_NAMES"
* Add your vm's resource group to the automation account variable: "VM_RG_NAME"
* Edit the snapshot expire threshold to your liking. Defaults to 90 days
* Edit the "create_snapshot_schedule" (day/time) to suit your needs, by default it runs Mon/Wed/Fri.
* Edit the "expire_snapshot_schedule", by default it runs monthly on the 1st

##### Notes:
* Snapshot expiration is scoped to the whole subscription 
* Snapshots are scoped to resource group
* The following automation account variables are set:
  * AZURE_SUB_ID: azure subscription id
  * VM_RG_NAME: resource group name that vms are built under
  * SNAP_EXPIRE_THRESHOLD: # of days until snapshot is removed
  * VM_NAMES: comma seperated values of vms to snap eg: my-az-vm-9873, my-az-vm-avd 

#### FYI:
* Python is wrapped in try/excepts which will aid in troubleshooting, check the runbooks job output for details/output
* Python libraries used:
   * azure_core
   * azure_identity
   * azure_mgmt_compute
   * azure_mgmt_core
   * azure_mgmt_msi
   * azure_mgmt_resource
   * msal
   * typing_extensions



