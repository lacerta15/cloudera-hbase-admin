#!/usr/bin/env bash
# Export HBase table to HDFS
set -euo pipefail
TABLE=${1:?Usage: $0 <table> <hdfs_path>}
HDFS_PATH=${2:?Usage: $0 <table> <hdfs_path>}
HBASE_CMD=${HBASE_CMD:-hbase}
echo "Exporting $TABLE to $HDFS_PATH ..."
$HBASE_CMD org.apache.hadoop.hbase.mapreduce.Export "$TABLE" "$HDFS_PATH"
echo "Export complete."
