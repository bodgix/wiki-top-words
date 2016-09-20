# Name

wiki_top_words.rb

# Synopsis

$ ./wiki_top_words.rb 21721040 10                                        ‹ruby-2.3.1@wiki-top-words›
Title: Stack Overflow
Top 10 words:
- 22 stack
- 21 questions
- 17 overflow
- 12 that
- 11 users
- 10 site
- 8 question
- 7 answer, answers
- 6 being, reputation
- 5 atwood, exchange, website, user, 2008

# Description

Reads the WikiPedia article whose ID is passed as an argument, and prints
a list of top N most common words in this article, where N is passed as an
argument as well.

# Requirements

The script requires the [HTTParty][httparty]

# Links

[httparty]: https://github.com/jnunemaker/httparty "Ruby HTTP client library"
