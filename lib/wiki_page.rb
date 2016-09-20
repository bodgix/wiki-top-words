# encoding: UTF-8
require 'httparty'
require 'json'

require_relative 'words_counter'

module WikiTopWords
  class WikiPage
    include HTTParty
    include WordsCounter

    attr_reader :page_id

    base_uri 'https://en.wikipedia.org/'
    API_URI = '/w/api.php'

    def initialize(page_id)
      @page_id = page_id
    end

    def content
      @content ||= JSON.parse(get_page)
    end

    def title
      content['query']['pages']["#{page_id}"]['title']
    end

    def extract
      content['query']['pages']["#{page_id}"]['extract']
    end

    def words
      extract.scan(/\w{4,}/)
    end

    private
    def default_query
      {
        action:       'query',
        prop:         'extracts',
        explaintext:  true,
        format:       'json'
      }
    end

    def get_page
      response = self.class.get(API_URI, query: default_query.merge(pageids: page_id))
      fail "WIKI returned a non 200 response: #{response.code}" unless response.code == 200
      response.body
    end
  end
end
