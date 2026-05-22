#!/usr/bin/env bash
# HBase health check via hbase shell
set -euo pipefail
HBASE_CMD=${HBASE_CMD:-hbase}
echo "=== HBase Cluster Status ==="
echo "status 'detailed'" | $HBASE_CMD shell -n 2>/dev/null | grep -E "servers|dead|regions"
echo ""
echo "=== HBase Master Status ==="
echo "status 'simple'" | $HBASE_CMD shell -n 2>/dev/null
