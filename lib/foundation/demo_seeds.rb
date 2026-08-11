# frozen_string_literal: true

module Foundation
  # Optional demo catalog rows (SPEC M10.3).
  #
  # The application boots and serves every page with an empty database, so no
  # seed is ever required. These rows exist only to make the storefront and
  # checkout walkable on a developer machine or in a hosted preview, and they
  # are refused everywhere else — a production deployment must never find
  # invented products in its catalog.
  module DemoSeeds
    PRODUCTS = [
      {
        slug: "saltmarsh-harbor-blend", sku: "SR-HARBOR-12",
        name: "Saltmarsh Harbor Blend",
        description: "Our house blend, named for the harbor fog that rolls in at dawn. Colombia and Ethiopia, medium-dark roasted. Notes of dark chocolate, caramel, and a whisper of sea salt. 12 oz whole bean.",
        price_cents: 1_800, position: 0, inventory_quantity: 60,
        image_url: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "dunewalker-espresso", sku: "SR-DUNE-12",
        name: "Dunewalker Espresso",
        description: "Brazil and Sumatra pulled dark for the morning rush. Bittersweet cocoa, toasted hazelnut, and a heavy, syrupy crema. 12 oz whole bean, dialed for espresso.",
        price_cents: 1_900, position: 1, inventory_quantity: 50,
        image_url: "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "tidal-pool-light-roast", sku: "SR-TIDAL-12",
        name: "Tidal Pool Light Roast",
        description: "Yirgacheffe, roasted light to keep every note bright. Citrus zest, jasmine, and a clean tea-like finish. 12 oz whole bean.",
        price_cents: 1_650, position: 2, inventory_quantity: 55,
        image_url: "https://images.unsplash.com/photo-1447933601403-0c6688de566e?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "marsh-grass-decaf", sku: "SR-DECAF-12",
        name: "Marsh Grass Decaf",
        description: "Swiss-water processed Colombia, so the afternoon cup still tastes like coffee. Brown sugar, almond, and a soft cocoa finish. 12 oz whole bean.",
        price_cents: 1_700, position: 3, inventory_quantity: 40,
        image_url: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "shipwreck-dark-roast", sku: "SR-WRECK-12",
        name: "Shipwreck Dark Roast",
        description: "Our darkest pull — a storm-lashed Sumatra roasted to the edge of the hull. Charred oak, molasses, and smoke. 12 oz whole bean, not for the faint of heart.",
        price_cents: 1_750, position: 4, inventory_quantity: 35,
        image_url: "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=900&q=80"
      },
      {
        slug: "driftwood-sampler", sku: "SR-SAMP-3X12",
        name: "Driftwood Sampler",
        description: "Three 4 oz bags: Harbor Blend, Tidal Pool, and Shipwreck. A tide of flavor to find your favorite. Whole bean.",
        price_cents: 2_400, position: 5, inventory_quantity: 30,
        image_url: "https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=900&q=80"
      }
    ].freeze

    # Development or a hosted preview only. Preview runs in the production
    # Rails environment, so the preview flag — not RAILS_ENV alone — is what
    # separates a disposable demo from a real deployment.
    def self.permitted?(rails_env: Rails.env, preview: Foundation.preview?)
      rails_env.development? || preview
    end

    def self.run!(io: $stdout)
      unless permitted?
        io.puts("Skipping demo seeds: they are limited to development and hosted previews.")
        return 0
      end

      unless Foundation.storefront_enabled?
        io.puts("Skipping demo seeds: the storefront is disabled in config/foundation.yml.")
        return 0
      end

      created = seed_products!
      io.puts("Demo catalog ready: #{PRODUCTS.length} products (#{created} created).")
      created
    end

    # Upserts by slug so repeated runs converge on the same catalog instead of
    # duplicating rows.
    def self.seed_products!
      created = 0

      PRODUCTS.each do |attributes|
        product = Foundation::Storefront::Product.find_or_initialize_by(slug: attributes[:slug])
        created += 1 if product.new_record?
        product.update!(**attributes, currency: "USD", active: true)
      end

      created
    end
  end
end
