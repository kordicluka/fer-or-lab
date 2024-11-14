import { NextResponse } from "next/server";
import { Pool } from "pg";

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export async function GET() {
  try {
    const client = await pool.connect();
    const result = await client.query(`
      SELECT p.*, 
             pr.naziv AS proizvodac_naziv, 
             pr.zemlja AS proizvodac_zemlja,
             array_agg(DISTINCT s.naziv) AS sastojci
      FROM pica p
      LEFT JOIN proizvodaci pr ON p.proizvodac_id = pr.id
      LEFT JOIN pica_sastojci ps ON p.id = ps.pice_id
      LEFT JOIN sastojci s ON ps.sastojak_id = s.id
      GROUP BY p.id, pr.id, pr.naziv, pr.zemlja
    `);

    const picaData = result.rows.map(({ proizvodac_id, ...row }) => ({
      ...row,
      proizvodac: {
        naziv: row.proizvodac_naziv,
        zemlja: row.proizvodac_zemlja,
      },
      sastojci: row.sastojci || [],
      proizvodac_naziv: undefined,
      proizvodac_zemlja: undefined,
    }));

    client.release();
    return NextResponse.json(picaData);
  } catch (err) {
    console.error(err);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
