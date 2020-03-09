json.extract! establishment, :id, :name, :cnpj, :phone,
              :fantasy_name, :has_delivery,
              :created_at, :updated_at,
              address:  establishment.address
json.url establishment_url(establishment, format: :json)
