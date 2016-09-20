# encoding: UTF-8

module WikiTopWords
  module ResultsPrinter
    def self.print_results(wiki_page, how_many)
      print_header(wiki_page, how_many)
      
      previous = wiki_page.sorted_words.shift
      txt = "- #{previous[1]} #{previous[0]}"

      while how_many > 0
        current = wiki_page.sorted_words.shift
        if current[1] == previous[1]
          txt << ", #{current[0]}"
        else
          puts txt
          txt = "- #{current[1]} #{current[0]}"
          how_many -= 1
        end
        previous = current
      end
    end

    def self.print_header(wiki_page, how_many)
      puts "Title: #{wiki_page.title}"
      puts "Top #{how_many} words:"
    end
  end
end
