# Bitwarden Secret Store for k3s

## Installation
```
helm repo add bitwarden https://charts.bitwarden.com/
helm repo update
helm show values bitwarden/sm-operator --devel > values.yaml
helm upgrade sm-operator bitwarden/sm-operator -i --debug -n bitwarden --create-namespace --values values.yaml --devel
```


## Create Bitwarden secrets
1. From Bitwarden Secrets Manager, you will need to create a "machine account"
2. Run the below command with the "machine account" token
```
kubectl create secret generic bw-auth-token -n bitwarden --from-literal=token="${BW_TOKEN}"
```

## Deploy BitwardenSecret
Need to explcitly expose the secret that should be synced from Bitwarden to Kubernetes Secret

```
cat <<EOF | kubectl apply -n bitwarden -f -
apiVersion: k8s.bitwarden.com/v1
kind: BitwardenSecret
metadata:
  name: bitwarden
spec:
  organizationId: "67133d60-9c46-4fe4-8e26-b1e001633fd7"
  secretName: bitwarden
  onlyMappedSecrets: true # default is true
  map:
    - bwSecretId: 36cc39d5-ecbd-4459-9f9b-b3f3004d53a9
      secretKeyName: db-001_password
  authToken:
    secretName: bw-auth-token
    secretKey: token
EOF
```

## Source
https://bitwarden.com/help/secrets-manager-kubernetes-operator/