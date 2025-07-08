get_replica_count() {
  local container_name=$1
  local port=$2
  docker compose exec -T $container_name mongosh --port $port --eval "
    rs.status().members.length
  "
}

shard1_replicas=$(get_replica_count shard1 27018)
shard2_replicas=$(get_replica_count shard2 27019)

echo "Количество реплик для shard1: $shard1_replicas"
echo "Количество реплик для shard2: $shard2_replicas"