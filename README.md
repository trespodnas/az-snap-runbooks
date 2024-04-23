# Runbooks for snapshot automation/expiration 

#### Requirements:
* Azure automation account
* Python = 3.8 > 
* Associated python libraries

###### ToDo's :
###### Create terraform IaC for deployment.

#### What does it do?:
Takes scheduled snapshots of named vm's <br>
Expires/removes all snapshots in subscription after set threshold, which is set via SNAP_EXPIRE_THRESHOLD variable.

#### Getting started:
* Clone this repo./copy to your environment<br>
* Create azure automation account, remove boilerplate runbooks
* Add the automationAccount's managed identity to the following roles : "Virtual Machine Contributor", "Disk Snapshot Contributor"
* Create automation account variables: AZURE_SUB_ID (encrypted), SNAP_EXPIRE_THRESHOLD (integer), VM_NAMES (string), VM_RG_NAME (string)
<br>

