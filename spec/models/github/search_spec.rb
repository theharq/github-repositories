require 'rails_helper'

RSpec.describe Github::Search do
  describe "#repositories" do
    it "Returns the result of the search term for repositories" do
      VCR.use_cassette('ruby_repositories') do
        searcher = Github::Search.new

        result = searcher.repositories(term: "ruby")

        expect(result["total_count"]).to eq(281354)
        expect(result["items"].size).to eq(10)
        expect(result["items"][0]["name"]).to eq("ruby")
        expect(result["items"][0]["full_name"]).to eq("ruby/ruby")
        expect(result["items"][0]["stargazers_count"]).to eq(15296)
        expect(result["items"][0]["forks_count"]).to eq(4096)
        expect(result["items"][0]["html_url"]).to eq("https://github.com/ruby/ruby")
      end
    end

    it "Returns the result sorted by forks" do
      VCR.use_cassette('ruby_repositories_sort_by_forks') do
        searcher = Github::Search.new

        result = searcher.repositories(term: "ruby", sort_by: "forks")

        expect(result["items"][0]["forks_count"]).to eq(4096)
      end
    end

    it "Returns the result listing different items per page" do
      VCR.use_cassette('ruby_repositories_30_per_page') do
        searcher = Github::Search.new

        result = searcher.repositories(term: "ruby", per_page: 30)

        expect(result["items"].size).to eq(30)
      end
    end

    it "Returns the result based from the page number" do
      VCR.use_cassette('ruby_repositories_different_page') do
        searcher = Github::Search.new

        result = searcher.repositories(term: "ruby", page: 7)

        expect(result["items"][0]["name"]).to eq("ruby_koans")
        expect(result["items"][0]["full_name"]).to eq("neall/ruby_koans")
      end
    end
  end
end