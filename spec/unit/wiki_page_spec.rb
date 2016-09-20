# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/wiki_page'
require 'pry-byebug'

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
    it 'gets the page and parse JSON' do
      expect(subject).to receive(:get_page) { page_content }
      expect(subject.content).to eql(JSON.parse(page_content))
    end
  end

  describe 'title' do
    it 'returns the title key from the content json' do
      expect(subject).to receive(:get_page) { content }
      expect(subject.title).to eql('Test')
    end
  end

  describe 'extract' do
    it 'returns the extract key from the content json' do
      expect(subject).to receive(:get_page) { content }
      expect(subject.extract).to eql('word1 and word2 word2 word1 word3')
    end
  end

  shared_examples 'article to words' do
    it 'transforms the article into an array of words' do
      expect(subject).to receive(:get_page) { content }
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
end
