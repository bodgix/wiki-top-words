# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/top_words_printer'

describe WikiTopWords::TopWordsPrinter do
  describe '#print_results' do
    let(:word) { ['word', 13] }
    let(:elements) do
      el = double
      expect(el).to receive(:reverse) { el }
      expect(el).to receive(:shift) { word }
      el
    end
    let(:wiki) do
      w = double
      expect(w).to receive(:page_url)
      expect(w).to receive(:title)
      expect(w).to receive(:sorted_elements) { elements }
      w
    end

    context 'when how_many equals 0' do
      let(:how_many) { 0 }
      it 'reads sorted words and page title from the wiki page and reverses words' do
        # silence the puts
        expect_any_instance_of(Kernel).to receive(:puts).at_least(:once)

        described_class.print_results(wiki, how_many)
      end
    end

    context 'when how_many is > 0' do
      let(:how_many) { 5 }
      context 'when no two words have the same count' do
        let(:elements) { [['word', 1], ['word1', 2], ['word2', 3]] }

        it 'prints all words in seperate lines' do
          expect_any_instance_of(Kernel).to receive(:puts).with('- 3 word2').once
          expect_any_instance_of(Kernel).to receive(:puts).with('- 2 word1').once
          expect_any_instance_of(Kernel).to receive(:puts).with('- 1 word').once
          expect_any_instance_of(Kernel).to receive(:puts).at_least(:once)

          described_class.print_results(wiki, how_many)
        end
      end

      context 'when there are words with the same count' do
        let(:elements) { [['word', 1], ['word1', 2], ['word2', 3], ['word3', 3]] }

        it 'prints words with the same count in the same line' do
          expect_any_instance_of(Kernel).to receive(:puts).with('- 3 word3, word2').once
          expect_any_instance_of(Kernel).to receive(:puts).with('- 2 word1').once
          expect_any_instance_of(Kernel).to receive(:puts).with('- 1 word').once
          expect_any_instance_of(Kernel).to receive(:puts).at_least(:once)

          described_class.print_results(wiki, how_many)
        end
      end
    end
  end
end
