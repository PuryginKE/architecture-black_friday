docker compose exec -T somedb mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "somedb:27017" }
    ]
  }
);
EOF

