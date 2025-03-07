#!  /usr/bin/bash

#   cria o servico Produtos
PAYLOAD=$( cat <<JSON 
{
    "name": "Peca",
    "uri": "http://localhost:3000/api/v1/peca",
    "enabled": true
}
JSON
)


SERVICEID=$(curl -i -X POST localhost:8001/services  --data "${PAYLOAD}" | grep -o '"id":"[^"]*' | grep -o '[^"]*$' )




#   cria o servico Produtos
PAYLOAD=$( cat <<JSON
{
    "name": "produto",
    "protocols": ["http", "https"],
    "methods": ["GET", "POST", "PATCH", "DELETE"],
    "hosts": ["localhost"],
    "paths": ["/v1/gateway/peca"],
    "https_redirect_status_code": 426,
    "regex_priority": 0,
    "strip_path": true,
    "path_handling": "v1",
    "preserve_host": false,
    "request_buffering": true,
    "response_buffering": true,
    "tags": ["user-level", "low-priority"],
    "service": {"id":"${SERVICEID}"}
}
JSON
)

curl -i -X POST localhost:8001/routes -h 'Content-Type: application/json' --data "${PAYLOAD}" 


        "code":2,
        "fields":
        {"
            {    
                "name": "Pecas",    
                "url": "http://localhost:3000/api/v1/peca\",
                "enabled": true
            }":"unknown field",
            "host":"required field missing"
        },
        "message":"2 schema violations (host: required field missing; {\n    \"name\": \"Pecas\",\n    \"url\": \"http://localhost:3000/api/v1/peca\",\n    \"enabled\": true\n}: unknown field)","name":"schema violation"}