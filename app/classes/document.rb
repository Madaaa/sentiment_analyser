class Document
  attr_accessor :words
  attr_accessor :klass

  def initialize klass: , path:
    @words = process_file(path)
    @klass = klass
  end

  def process_file path
    TextProcessor.new(path)
      .to_stem_words
      .eliminate_punctuation
      .eliminate_stop_words
      .to_vec
  end
end
