```
cd /opt/code/oqfe_wdl
id=$(curl -X POST --header "Accept: application/json"    -v "localhost:8000/api/workflows/v1" -F workflowSource=@oqfe.wdl -F workflowInputs=@tests/testinstance.json | jq -r ".id")
curl -X GET --header "Accept: application/json"    -v "localhost:8000/api/workflows/v1/$id/metadata" | jq '.status'
```