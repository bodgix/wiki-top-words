#!/usr/bin/env ruby
# encoding: UTF-8

require_relative 'lib/wiki_page'
require_relative 'lib/result_printer'

PARAM_ERROR = 1

def parse_options(argv)
  error(usage, PARAM_ERROR) if argv.length != 2
  options = OpenStruct.new
  options.page_id = argv[0]
  options.words_no = argv[1].to_i
  options
end

def error(msg, code)
  puts msg
  exit(code)
end

def usage
  "Usage: #{$PROGRAM_NAME} <ARTICLE_ID> <TOP_WORDS_NUMBER>"
end

def main
  options = parse_options(ARGV)

  wiki_page = WikiTopWords::WikiPage.new(options.page_id)
  WikiTopWords::ResultsPrinter.print_results(wiki_page, options.words_no)
end

if $PROGRAM_NAME == __FILE__
  main
end
