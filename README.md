# SifoRestaurant

Restaurant management for dine-in, takeaway and delivery.

- Product: SifoRestaurant
- Domain: https://restaurant.sifobooks.com
- Currency: ZMW
- Market: Zambia
- Architecture: independent application, database, authentication and deployment

## Foundation status

This repository contains the initial frontend foundation. Data shown in the dashboard is demonstration state only. Production authentication, persistence, role enforcement, integrations and compliance workflows must be implemented and tested before live use.

## Development

```bash
npm install
npm run dev
npm run build
```

## Product modules

- Dashboard
- Tables & Reservations
- Menu & Modifiers
- POS Orders
- Kitchen Display
- Bar Display
- Recipes & Stock
- Purchasing
- Wastage
- Shifts & Cash
- Reports
- Settings

## Security and compliance

- Enforce tenant/company and branch isolation server-side.
- Apply role-based permissions and immutable audit events.
- Keep credentials and API secrets server-side.
- Add ZRA Smart Invoice/VSDC integration where applicable after approved technical onboarding.
- Do not treat demo values as accounting or lending records.
