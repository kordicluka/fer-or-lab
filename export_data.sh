#!/bin/bash

# Create a temporary SQL file
cat << EOF > export_commands.sql
\o pica.csv
COPY (
  SELECT p.id, p.naziv, p.vrsta, p.podvrsta, pr.naziv AS proizvodac, pr.zemlja,  
         p.godina_proizvodnje, p.postotak_alkohola, p.volumen, p.cijena,
         string_agg(s.naziv, ', ') AS sastojci
  FROM pica p
  JOIN proizvodaci pr ON p.proizvodac_id = pr.id
  LEFT JOIN pica_sastojci ps ON p.id = ps.pice_id
  LEFT JOIN sastojci s ON ps.sastojak_id = s.id
  GROUP BY p.id, p.naziv, p.vrsta, p.podvrsta, pr.naziv, pr.zemlja, 
           p.godina_proizvodnje, p.postotak_alkohola, p.volumen, p.cijena
) TO STDOUT WITH CSV HEADER;
\o

\t
\a
\o pica_temp.json
WITH drink_data AS (
  SELECT 
    p.id,
    p.naziv,
    p.vrsta,
    p.podvrsta,
    json_build_object('naziv', pr.naziv, 'zemlja', pr.zemlja) as proizvodac,
    p.godina_proizvodnje,
    p.postotak_alkohola,
    p.volumen,
    p.cijena,
    (
      SELECT json_agg(s.naziv)
      FROM pica_sastojci ps
      JOIN sastojci s ON ps.sastojak_id = s.id
      WHERE ps.pice_id = p.id
    ) as sastojci
  FROM pica p
  JOIN proizvodaci pr ON p.proizvodac_id = pr.id
)
SELECT jsonb_pretty(jsonb_build_object(
  'pica', (SELECT json_agg(drink_data) FROM drink_data)
));
\o
EOF

# Execute the SQL commands
psql -h 157.90.244.229 -U postgres -d pica_db -f export_commands.sql

# Clean up the JSON output - remove PostgreSQL formatting artifacts
sed -e 's/+$//g' -e 's/^[-]\{1,\}$//' pica_temp.json | grep -v '^$' | grep -v '(1 row)' > pica.json

# Clean up temporary files
rm export_commands.sql pica_temp.json

echo "Export completed successfully."

# Verify JSON validity
if command -v jq &> /dev/null && jq empty pica.json 2>/dev/null; then
    echo "JSON validation successful"
else
    echo "Warning: Could not validate JSON (jq not installed or invalid JSON)"
fi