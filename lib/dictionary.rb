# frozen_string_literal: true

# This class deals with removing and replacing words.
class Dictionary
  attr_reader :words_to_remove, :columns_to_remove, :words_to_replace

  def initialize(words_to_remove, columns_to_remove, words_to_replace)
    @words_to_remove = words_to_remove
    @columns_to_remove = columns_to_remove
    @words_to_replace = words_to_replace
  end

  def remove_words(array_of_strings)
    array_of_strings - words_to_remove
  end

  def remove_columns(csv)
    csv.delete(*columns_to_remove)
    csv
  end

  def replace_words(csv)
    csv.by_row!
    csv.each do |row|
      row.filter_map do |header, value|
        row[header] = words_to_replace[value] if word_to_replace?(value)

        value
      end
    end
    csv.by_col_or_row!
  end

  private

  def word_to_replace?(word)
    return true if words_to_replace.keys.include?(word)

    false
  end
end
