module Api
    # utils
    class Query
        def self.filters(filters, params)
            filters.map{ |key| params.has_key?(key) ? {key => params[key]} : {} }
                   .inject({}){|hash, injected| hash.merge!(injected)}
        end
    end
end