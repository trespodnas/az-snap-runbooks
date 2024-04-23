# Runbooks for snapshot automation/expiration 

#### Requirements:
* Azure automation account
* Python = 3.8 > 
* Associated python libraries

###### ToDo's :
###### Create terraform IaC for deployment.
###### Use diffrent method to capture vm names for snapshot creation, currently using an env. variable .

#### What does it do?:
Creates two python runbooks under an automation account 
Takes scheduled snapshots of named vm's <br>
Expires/removes all snapshots in subscription after set threshold, which is set via SNAP_EXPIRE_THRESHOLD variable.

#### Getting started:
* Clone this repo./copy to your environment<br>
* Create azure automation account, remove boilerplate runbooks

#### Setup:
* Add the automationAccount's managed identity to the following roles : "Virtual Machine Contributor", "Disk Snapshot Contributor"
* Create automation account variables: AZURE_SUB_ID (encrypted), SNAP_EXPIRE_THRESHOLD (integer), VM_NAMES (string), VM_RG_NAME (string)
& fill in appropriate details (see details below)<br>
* Upload required python packages (currently):
* * azure_core
   * azure_identity
   * azure_mgmt_compute
   * azure_mgmt_core
   * azure_mgmt_msi
   * azure_mgmt_resource
   * msal
   * typing_extensions
* Create schedules
* Attach schedules to each runbook
* TEST
* Python is wrapped in try/excepts which will aid in troubleshooting, check the runbooks job output for details/output


##### Notes:
* Snapshot expiration is scoped to the whole subscription 
* Snapshots are scoped to resource group
* AZURE_SUB_ID: azure subscription id
* VM_RG_NAME: resource group name that vms are built under
* SNAP_EXPIRE_THRESHOLD: # of days until snapshot is removed
* VM_NAMES: comma seperated values of vms to snap eg: my-az-vm-9873, my-az-vm-avd 