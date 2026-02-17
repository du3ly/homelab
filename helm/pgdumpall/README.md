# Postgres Backup to NAS
Create a `CronJob` to run `pg_dumpall` that will run a full backup and store it on the NAS (NFS)

## Installation
```
kubectl create ns pgdump
kubectl create secret generic bw-auth-token -n pgdump --from-literal=token="${BW_TOKEN}"
kubectl -n pgdump apply -f bitwarden-secretstore.yaml
kubectl -n pgdump apply -f pv.yaml
kubectl -n pgdump apply -f pgdumpall.yaml
```

## Test

```
kubectl create job --from=cronjob/pg-backup pg-backup-manual -n pgdump
```