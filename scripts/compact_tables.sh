#!/usr/bin/env bash
# Major compact all HBase tables
set -euo pipefail
HBASE_CMD=${HBASE_CMD:-hbase}
echo "Fetching table list..."
TABLES=$(echo "list" | $HBASE_CMD shell -n 2>/dev/null | grep -v "TABLE" | grep -v "^$" | grep -v "row")
for table in $TABLES; do
    echo "Major compacting: $table"
    echo "major_compact '$table'" | $HBASE_CMD shell -n 2>/dev/null
done
echo "Done."
