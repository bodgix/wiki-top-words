# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/elements_counter'

describe ElementsCounter do
  let(:subject) { class Test; include ElementsCounter; end.new }
  before { @test_words = %w[word1 word2 word3 word1 word1 word2] }

  describe 'elements_with_count' do
    it 'calls a block for every element' do
      element = double
      test_data = [element, element, element]
      expect(element).to receive(:test).exactly(3).times
      expect(subject).to receive(:to_a) { test_data }

      subject.elements_with_count(&:test)
    end

    it 'returns a hash with elements and number of occurances' do
      expected_result = {
        'word1' => 3,
        'word2' => 2,
        'word3' => 1
      }
      expect(subject).to receive(:to_a) { @test_words }
      expect(subject.elements_with_count).to eql(expected_result)
    end
  end

  describe 'sorted_elements' do
    it 'returns an array sorted by the number of occurances of an element' do
      expected_result = [['word3', 1], ['word2', 2], ['word1', 3]]
      expect(subject).to receive(:to_a) { @test_words }
      expect(subject.sorted_elements).to eql(expected_result)
    end
  end
end
