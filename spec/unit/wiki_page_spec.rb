# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/wiki_page'

describe WikiTopWords::WikiPage do
  let(:page_id) { 42 }
  let(:subject) { described_class.new(page_id) }
  let(:content) do
    File.read("spec/data/wikipedia_#{page_id}.json")
  end
  describe '#new' do
    it 'initializes an object and returns it' do
      expect(subject).to be_a(described_class)
      expect(subject.page_id).to eql(page_id)
    end
  end

  describe 'content' do
    let(:page_content) { '{"test": 42}' }
    it 'gets the page and parses JSON' do
      expect(subject).to receive(:page_json) { page_content }
      expect(subject.content).to eql(JSON.parse(page_content))
    end
  end

  describe 'title' do
    it 'returns the title key from the content json' do
      expect(subject).to receive(:page_json) { content }
      expect(subject.title).to eql('Test')
    end
  end

  describe 'extract' do
    it 'returns the extract key from the content json' do
      expect(subject).to receive(:page_json) { content }
      expect(subject.extract).to eql('word1 and word2 word2 word1 word3')
    end
  end

  shared_examples 'article to words' do
    it 'transforms the article into an array of words' do
      expect(subject).to receive(:page_json) { content }
      expect(method).to eql(%w(word1 word2 word2 word1 word3))
    end
  end

  describe 'words' do
    let(:method) { subject.words }
    it_behaves_like 'article to words'
  end

  describe 'to_a' do
    let(:method) { subject.to_a }
    it_behaves_like 'article to words'
  end

  describe 'url' do
    let(:page42_url) { 'https://en.wikipedia.org/w/api.php?action=query&prop=extracts&explaintext=true&format=json&pageids=42' }
    it 'retrieves content and returns the URL used' do
      url = subject.url
      expect(url).to eql(page42_url)
    end
  end

  describe 'page_json' do
    let(:code) { 200 }
    let(:response) do
      r = double('response')
      req = double
      expect(r).to receive(:code).at_least(:once) { code }
      allow(r).to receive(:request) { req }
      allow(req).to receive(:last_uri) { 'test' }
      r
    end
    before do
      default_query = {
        action:       'query',
        prop:         'extracts',
        explaintext:  true,
        format:       'json'
      }
      expect(described_class).to receive(:get) \
        .with('/w/api.php',
              query: default_query.merge(pageids: page_id)) { response }

      # get_page is a private method. we need a wrapper public method
      subject.instance_eval do
        def call_page_json
          page_json
        end
      end
    end

    context 'when wikipedia returns 200 OK' do
      it 'does a HTTP GET, returns the page content and saves the URL' do
        expect(response).to receive(:body) { 'test' }
        expect(subject.call_page_json).to eql('test')

      end
    end

    context 'when wikipedia returns a non-200 code' do
      let(:code) { 500 }
      it 'does a HTTP get and raises an error' do
        expect { subject.call_page_json }.to raise_error(RuntimeError)
      end
    end
  end
end
