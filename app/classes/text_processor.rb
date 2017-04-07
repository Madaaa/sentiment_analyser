class TextProcessor
  attr_accessor :text

  def initialize path
    @text = File.open(path, 'rb').read
  end

  def eliminate_stop_words
    filter = Stopwords::Snowball::Filter.new :en
    @text = filter.filter text.split
    @text = @text.join(' ')

    self
  end

  def eliminate_punctuation
    @text.gsub!(/[^a-z0-9\s]/i, '')

    self
  end

  def to_stem_words
    stemmer = Lingua::Stemmer.new(language: 'en')

    @text = @text.split(' ').inject([]) do |acc, word|
      acc << stemmer.stem(word)
      acc
    end.join(' ')

    self
  end

  def to_uniq_words
    @text = @text.split(' ').uniq.join(' ')

    self
  end

  def to_vec
    @text.split(' ')
  end
end
