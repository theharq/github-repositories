require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /" do
    it "Returns a valid response" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "Returns a list of repositories when a parameter is sent" do
      VCR.use_cassette('ruby_repositories') do
        get root_path, params: {term: "ruby"}
        expect(response).to have_http_status(200)
        expect(response.body).to include("Listing 10 from 281354 results")
        expect(response.body).to include("The Ruby Programming Language")
      end
    end
  end
end
