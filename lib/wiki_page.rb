# encoding: UTF-8
require 'httparty'
require 'json'

require_relative 'elements_counter'

module WikiTopWords
  # Wikipedia page abstraction class
  class WikiPage
    include HTTParty
    include ElementsCounter

    attr_reader :page_id
    attr_writer :page_url

    base_uri 'https://en.wikipedia.org/'
    API_URI = '/w/api.php'.freeze
    MIN_WORD_LENGTH = 4
    DEFAULT_QUERY = {
      action:       'query',
      prop:         'extracts',
      explaintext:  true,
      format:       'json'
    }.freeze

    def initialize(page_id)
      @page_id = page_id
    end

    def content
      @content ||= JSON.parse(page_json)
    end

    def title
      content['query']['pages'][page_id.to_s]['title']
    end

    def extract
      content['query']['pages'][page_id.to_s]['extract']
    end

    def words
      @words ||= extract.scan(/\w{#{MIN_WORD_LENGTH},}/)
    end

    def to_a
      words
    end

    def page_url
      content # A request has to be made to know the URL.
      @page_url
    end

    private

    def page_json
      response = self.class.get(API_URI,
                                query: DEFAULT_QUERY.merge(pageids: page_id))
      raise "WIKI returned a non 200 response: #{response.code}" \
        unless response.code == 200
      self.page_url = response.request.last_uri.to_s
      response.body
    end
  end
end
