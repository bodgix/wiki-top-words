# encoding: UTF-8

# Top level encapsulating module for the project
module WikiTopWords
  # Print the TOP N words
  module TopWordsPrinter
    def self.print_results(wiki_page, how_many)
      words_rev_order = wiki_page.sorted_elements(&:downcase).reverse

      print_header(wiki_page, how_many)
      merged_top_n = merge_equal_words(words_rev_order, how_many)
      print_words(merged_top_n)
    end

    def self.print_header(wiki_page, how_many)
      puts "URL: #{wiki_page.page_url}"
      puts "Title: #{wiki_page.title}"
      puts "Top #{how_many} words:"
    end

    def self.print_words(words)
      words.each do |word_with_count|
        puts "- #{word_with_count[1]} #{word_with_count[0]}"
      end
    end

    def self.merge_equal_words(words, how_many)
      words.each_with_object([words.shift]) do |word_with_count, merged|
        if word_with_count[1] == merged.last[1]
          merged.last[0] += ", #{word_with_count[0]}"
        else
          merged << word_with_count
        end
        break merged if merged.size == how_many
      end
    end
  end
end
