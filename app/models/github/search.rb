module Github
  class Search
    API_HOST = "https://api.github.com"

    # Response structure: https://developer.github.com/v3/search/#search-repositories
    def repositories(term:, sort_by: 'stars', per_page: 10, page: 1)
      response = connection.get("search/repositories", q: term,
                                                       sort_by: sort_by,
                                                       per_page: per_page,
                                                       page: page)
      Oj.load(response.body)
    end

    private

    def connection
      @connection ||= We::Call::Connection.new(host: API_HOST, timeout: 10)
    end
  end
end
