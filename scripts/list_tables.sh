#!/usr/bin/env bash
# List all HBase tables with row counts
set -euo pipefail
HBASE_CMD=${HBASE_CMD:-hbase}
TABLES=$(echo "list" | $HBASE_CMD shell -n 2>/dev/null | grep -v "TABLE" | grep -v "^$" | grep -v "row")
for table in $TABLES; do
    COUNT=$(echo "count '$table', INTERVAL => 100000" | $HBASE_CMD shell -n 2>/dev/null | tail -1)
    echo "$table : $COUNT"
done
