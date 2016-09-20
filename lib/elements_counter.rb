# encoding: UTF-8

module ElementsCounter
  # Returns a Hash with elements as keys and number of occurances as values
  #
  # @param [Proc] &block an optional block to be applied to elements before counting
  # @return [Hash] unique elements and number of occurances
  def elements_with_count(&block)
    @elements_with_count ||= to_a.reduce(Hash.new(0)) do |counter, element|
      transformed_element = block && block.call(element) || element
      counter[transformed_element] += 1
      counter
    end
  end

  # Counts and sorts the elements by the number of occurances
  #
  # @param [Proc] &block optional transformation to be applied to elements
  # @return [Array] a sorted array of the form:  [ [elem1, 10], [elem2, 5], ... ]
  def sorted_elements(&block)
    @sorted_elements ||= elements_with_count(&block).to_a.sort { |a, b| a[1] <=> b[1] }
  end
end
