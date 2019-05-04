# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../wiki_top_words'

describe 'wiki_top_words' do
  let(:argv) { %w[42 5] }

  describe 'parse_options' do
    context 'when wrong number of options is passed' do
      let(:argv) { ['test1'] }
      it 'prints an error and exits' do
        expect_any_instance_of(Kernel).to receive(:puts)
        expect { parse_options(argv) }.to raise_error(SystemExit)
      end
    end

    context 'when correct number of arguments is passed' do
      it 'returns the options' do
        options = parse_options(argv)
        expect(options.page_id).to eql('42')
        expect(options.words_no).to eql(5)
      end
    end
  end

  describe 'main' do
    it 'parses options, creates a wiki page prints results with a printer' do
      options = double
      expect_any_instance_of(Object).to receive(:parse_options) { options }
      expect(options).to receive(:page_id)
      expect(options).to receive(:words_no)

      expect(WikiTopWords::WikiPage).to receive(:new)
      expect(WikiTopWords::TopWordsPrinter).to receive(:print_results)
      main
    end
  end
end
