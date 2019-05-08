class TextAnalyzer
  attr_reader :text, :words, :uniq_words, :words_frequency

  def initialize text
    @text = text
    @words = text.scan(/[a-z]+/i)
    @uniq_words = Set.new(words)

    @words_frequency = uniq_words.reduce({}) { |hash, word| hash[word] = 0; hash }
    words.each { |word| words_frequency[word] += 1 }
  end

  def count_words
    words.count
  end

  def count_special_symbols
    text.scan(/[\W]/).count
  end

  def count_numbers
    text.scan(/\d+[\.,]{0,1}\d*/).count
  end

  def longest_word
    uniq_words.max { |a, b| a.length <=> b.length }
  end

  def shortest_word
    uniq_words.min { |a, b| a.length <=> b.length }
  end

  def most_frequent_words
    words_by_frequency(words_frequency.values.max)
  end

  def least_frequent_words
    words_by_frequency(words_frequency.values.min)
  end

  def words_by_frequency expected_frequency
    words_frequency.select { |word, frequency| frequency == expected_frequency }.keys
  end

  def without_shortest_word
    text.gsub(shortest_word, '').to_s
  end

  def replace_letters_with_numbers
    abc = ('a'..'z').to_a

    dictionary = abc
      .zip(1..abc.length)
      .map { |letter, index| [letter, index.to_s.rjust(2, '0')] }
      .to_h

    new_text = text.dup

    dictionary.each { |letter, index| new_text.gsub!(/#{ letter }/i, index) }

    new_text
  end
end
