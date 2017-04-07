class KlassExamples
  attr_accessor :klass
  attr_accessor :docs

  delegate :size, to: :docs

  def initialize klass: , doc_paths:
    @docs = doc_paths.map { |path| Document.new(klass: klass, path: path) }
  end

  def words
    @words ||= docs.map(&:words).flatten
  end

  def nr_of_words
    @nr_of_words ||= words.flatten.size
  end

  def words_frequency
    @words_frq ||= words.inject(Hash.new(0)) do |acc, word|
      acc[word] += 1
      acc
    end
  end
end
