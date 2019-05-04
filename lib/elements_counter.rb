# frozen_string_literal: true

# Counting occurances of elements in a collection
# Can be mixed-in to classes which implement to_a
module ElementsCounter
  # Returns a Hash with elements as keys and number of occurances as values
  #
  # @param [Proc] &block optional block ran on elements before counting
  # @return [Hash] unique elements and number of occurances
  def elements_with_count(&block)
    @elements_with_count ||= to_a.each_with_object(Hash.new(0)) do |el, cnt|
      transformed_element = block && yield(el) || el
      cnt[transformed_element] += 1
    end
  end

  # Counts and sorts the elements by the number of occurances
  #
  # @param [Proc] &block optional transformation to be applied to elements
  # @return [Array] a sorted array of the form: [ [elem1, 10], [elem2, 5], ...]
  def sorted_elements(&block)
    @sorted_elements ||= elements_with_count(&block).to_a.sort do |a, b|
      a[1] <=> b[1]
    end
  end
end
