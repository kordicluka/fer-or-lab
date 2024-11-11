# Otvoreni skup podataka o pićima

## Deployment

Aplikacija je dostupna na: [https://or-brown.vercel.app/](https://or-brown.vercel.app/)

## Opis projekta

Web aplikacija za prikaz i pretraživanje podataka o pićima. Aplikacija omogućuje filtriranje podataka po različitim kategorijama, preuzimanje podataka u CSV i JSON formatu, te pregled podataka u tabličnom obliku.

## Tehnologije

- Next.js 15 (App Router)
- TypeScript
- PostgreSQL
- Tailwind CSS
- shadcn/ui komponente
- Vercel (hosting)

## Lokalno pokretanje

### Preduvjeti

- Node.js (v18 ili noviji)
- npm (Node Package Manager)
- PostgreSQL baza podataka

### Postavljanje projekta

1. Klonirajte repozitorij:

```bash
git clone https://github.com/kordicluka/or-lab2.git
cd or-lab2
```

2. Instalirajte dependencies:

```bash
npm install
```

3. Kreirajte `.env.local` datoteku u root direktoriju projekta i dodajte sljedeće varijable:

```
DATABASE_URL=postgresql://korisnik:lozinka@localhost:5432/naziv_baze
```

4. Pokrenite razvojni server:

```bash
npm run dev
```

5. Otvorite [http://localhost:3000](http://localhost:3000) u vašem pregledniku za pregled aplikacije.

## Struktura projekta

- `app/` - Next.js App Router stranice i komponente
- `components/` - Ponovno iskoristive React komponente
- `public/` - Statički resursi
- `pica-schema.json` - JSON Schema za skup podataka

## API Endpoints

- `GET /api/pica` - Dohvaća sve podatke o pićima
- Podaci su dostupni i u CSV i JSON formatu kroz sučelje aplikacije

## Licenca

Creative Commons Attribution 4.0 International (CC BY 4.0)
