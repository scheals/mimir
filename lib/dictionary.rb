# frozen_string_literal: true

# This class deals with removing and replacing words.
class Dictionary
  attr_reader :words_to_remove

  def initialize(words_to_remove)
    @words_to_remove = words_to_remove
  end

  def remove_words(array_of_strings)
    array_of_strings - words_to_remove
  end
end
