#!/usr/bin/env bash
# Detect and optionally drop empty tables
set -euo pipefail
DRY_RUN=${DRY_RUN:-1}
HBASE_CMD=${HBASE_CMD:-hbase}
TABLES=$(echo "list" | $HBASE_CMD shell -n 2>/dev/null | grep -v "TABLE" | grep -v "^$" | grep -v "row")
for table in $TABLES; do
    COUNT=$(echo "count '$table'" | $HBASE_CMD shell -n 2>/dev/null | grep -oP '\d+ row' | awk '{print $1}')
    if [[ "$COUNT" == "0" ]]; then
        echo "Empty table: $table"
        if [[ "$DRY_RUN" == "0" ]]; then
            echo "disable '$table'; drop '$table'" | $HBASE_CMD shell -n 2>/dev/null
            echo "Dropped: $table"
        fi
    fi
done
