# encoding: UTF-8

module WikiTopWords
  module WordsCounter
    def counted_words
      return @counted_words if @counted_words
      @counted_words = Hash.new(0)
      words.each { |word| @counted_words[word.downcase] += 1 }
      @counted_words
    end

    def words_as_array
      @words_as_array ||= counted_words.to_a
    end

    def sorted_words
      # The counted words array is built using Hash::to_a so it looks like:
      # [ ['words1', 3], ['word2', 5], ... ]
      @sorted_words ||= words_as_array.sort { |a, b| a[1] <=> b[1] }.reverse
    end
  end
end
