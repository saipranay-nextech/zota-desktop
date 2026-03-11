#!/bin/bash
# Export a schema-only dump from a working database
# Usage: ./scripts/export-schema.sh [password]
#
# This creates a schema dump (no data) that can be imported on fresh installs.
# Run this against a database that has ALL tables and columns.

PGPASSWORD="${1:-postgres}"
DB_NAME="customer"
OUTPUT_FILE="$(dirname "$0")/../assets/schema.sql"

export PGPASSWORD

echo "Exporting schema from database '$DB_NAME'..."

pg_dump -U postgres -d "$DB_NAME" \
  --schema-only \
  --no-owner \
  --no-privileges \
  --no-comments \
  --if-exists \
  --clean \
  > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
  echo "Schema exported to: $OUTPUT_FILE"
  echo "Size: $(wc -c < "$OUTPUT_FILE") bytes"
else
  echo "ERROR: pg_dump failed"
  exit 1
fi
