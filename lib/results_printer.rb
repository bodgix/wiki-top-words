# encoding: UTF-8

module WikiTopWords
  module ResultsPrinter
    def self.print_results(wiki_page, how_many)
      print_header(wiki_page, how_many)

      words_rev_order = wiki_page.sorted_elements { |word| word.downcase }.reverse

      previous = words_rev_order.shift
      txt = "- #{previous[1]} #{previous[0]}"

      while how_many > 0
        current = words_rev_order.shift
        if current && current[1] == previous[1]
          txt << ", #{current[0]}"
        else
          puts txt
          break unless current # we may have ran out of words before how_many
          txt = "- #{current[1]} #{current[0]}"
          how_many -= 1
        end
        previous = current
      end
    end

    def self.print_header(wiki_page, how_many)
      puts "URL: #{wiki_page.page_url}"
      puts "Title: #{wiki_page.title}"
      puts "Top #{how_many} words:"
    end
  end
end
