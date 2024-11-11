import Link from "next/link";

export default function Home() {
  return (
    <div className="container mx-auto px-4">
      <main className="py-20">
        <h1 className="text-4xl font-bold mb-8">
          Otvoreni skup podataka o pićima
        </h1>

        <section className="mb-12">
          <h2 className="text-2xl font-semibold mb-4">O skupu podataka</h2>
          <p className="mb-4">
            Ovaj skup podataka sadrži informacije o različitim pićima,
            uključujući njihove nazive, vrste, proizvođače, sastojke i druge
            relevantne podatke.
          </p>
          <p className="mb-4">
            Licenca: Creative Commons Attribution 4.0 International (CC BY 4.0)
          </p>
        </section>

        <section className="mb-12">
          <h2 className="text-2xl font-semibold mb-4">Preuzimanje podataka</h2>
          <div className="flex space-x-4">
            <Link
              href="/pica.csv"
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
            >
              Preuzmi CSV
            </Link>
            <Link
              href="/pica.json"
              className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
            >
              Preuzmi JSON
            </Link>
          </div>
        </section>

        <section>
          <h2 className="text-2xl font-semibold mb-4">Pregled podataka</h2>
          <Link
            href="/datatable"
            className="bg-purple-500 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded"
          >
            Otvori tablični prikaz
          </Link>
        </section>
      </main>
    </div>
  );
}
