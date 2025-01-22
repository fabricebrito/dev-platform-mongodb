echo "Below the secret data for mongodb"

kubectl get -n mongodb secret mongodb -o jsonpath="{.data}" | jq -r 'to_entries[] | "\(.key): \(.value | @base64d)"'