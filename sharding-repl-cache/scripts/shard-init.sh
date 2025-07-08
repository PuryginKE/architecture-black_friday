init_or_reconfig_replica_set() {
  local container_name=$1
  local port=$2
  local replset_id=$3
  local config_file=$4

  docker compose exec -T $container_name mongosh --port $port <<EOF
try {
  rs.status();
  print("Replica set already initialized. Reconfiguring...");
  rs.reconfig($config_file);
} catch (e) {
  if (e.code == 94) {
    print("Replica set not initialized. Initializing...");
    rs.initiate($config_file);
  } else {
    print(e);
  }
}
EOF
}

init_or_reconfig_replica_set shard1 27018 "shard1" '{
  _id : "shard1",
  members: [
    { _id : 0, host : "shard1:27018" },
    { _id : 1, host : "shard1_replica1:27021" },
    { _id : 2, host : "shard1_replica2:27022" }
  ]
}'

init_or_reconfig_replica_set shard2 27019 "shard2" '{
  _id : "shard2",
  members: [
    { _id : 0, host : "shard2:27019" }
  ]
}'