# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/top_words_printer'

describe WikiTopWords::TopWordsPrinter do
  let(:elements) do
    el = double('elements')
    allow(el).to receive(:reverse) { el }
    el
  end
  let(:wiki) do
    w = double('wiki')
    allow(w).to receive(:url)
    allow(w).to receive(:title)
  end
  let(:how_many) { 5 }

  describe '#print_results' do
    it 'gets the words from wiki, reverses and merges them, and prints' do
      expect(wiki).to receive(:sorted_elements) { elements }
      expect(elements).to receive(:reverse)
      expect(described_class).to receive(:print_header)
      expect(described_class).to receive(:merge_equal_words)
      expect(described_class).to receive(:print_words)
      described_class.print_results(wiki, how_many)
    end
  end

  describe '#print_header' do
    it 'prints the URL, Title and How many words' do
      expect(wiki).to receive(:url) { 'testURL' }
      expect(wiki).to receive(:title) { 'Test title' }
      expect_any_instance_of(Kernel).to receive(:puts).exactly(3).times
      described_class.print_header(wiki, how_many)
    end
  end

  describe '#print_words' do
    let(:words) { [['word1', 3], ['word2', 1]] }
    it 'prints every word and the number of occurences in a separate line' do
      expect_any_instance_of(Kernel).to receive(:puts).with('- 3 word1').once
      expect_any_instance_of(Kernel).to receive(:puts).with('- 1 word2').once
      described_class.print_words(words)
    end
  end

  describe '#merge_equal_words' do
    let(:words) { [['word1', 3], ['word2', 3], ['word3', 2], ['word4', 1]] }
    it 'combines words with the same number of occurences' do
      merged_words = [ ['word1, word2', 3], ['word3', 2], ['word4', 1] ]
      expect(described_class.merge_equal_words(words, how_many)).to eql(merged_words)
    end
  end
end
