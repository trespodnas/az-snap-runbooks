locals {
  runbook_properties= {
    "create-snapshots-runbook" = {
      file_path = "${path.cwd}/../snapShotCreation/createsnapshot.py"
    }
    "expire-snapshots-runbook" = {
      file_path = "${path.cwd}/../snapShotExpiration/expiresnapshots.py"
    }
  }
}