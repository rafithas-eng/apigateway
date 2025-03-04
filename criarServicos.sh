#!  /usr/bin/ksh

#   cria o servico Produtos
PAYLOAD=$( cat <<JSON 
{
    "name": "Pecas",
    "url": "http://localhost:3000/api/v1/peca",
    "enabled": true
}
JSON
)

curl -i -X POST localhost:8001/services --data "${PAYLOAD}"


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
    "service": {"id":"$service-id"}
}
JSON
)


