<!-- foundation:identity -->
# Saltmarsh Roast

Online store for a small coastal coffee roaster: browse a catalog of roasted coffees with photos and prices, build a cart, check out as a guest, and revisit past orders.

- Site: https://saltmarsh-roast.api.holode.xyz
- Support: support@saltmarsh-roast.api.holode.xyz
<!-- /foundation:identity -->

## What this is

Online store for a small coastal coffee roaster: browse a catalog of roasted coffees with photos and prices, build a cart, check out as a guest, and revisit past orders.

## Who it is for

- Customer (guest checkout or signed-in account)
- Store admin (manage products and orders)

## Main features

- **Browse catalog** — Visitor sees products with photos, roast profile, origin, tasting notes, and price.
- **Add to cart** — Visitor adds quantities to a cart without an account.
- **Checkout** — Guest checkout collects an email; order completes through the local test simulator in the preview.
- **View past orders** — Signed-in customers see their order history; guests reach their receipt via a signed expiring access link.
- **Admin manage store** — Admin creates/edits products and views orders.

## Core entities

- Product
- Order
- OrderItem
- CustomerAccount

## Included foundation modules

- storefront

## Run locally

```bash
bundle install
bin/rails db:prepare
bin/dev
```

Requires Ruby, PostgreSQL, and the usual Rails toolchain. See `bin/setup` if present.

## Demo

Six coffees with roast names, origins, roast levels, tasting notes, weights, prices, and photos; a couple of seeded orders for the demo account so order history is visible.

## Deploy notes

Production `config.hosts` is derived from `domain` in `config/foundation.yml`. Keep that value aligned with the real host or every request will 403.
