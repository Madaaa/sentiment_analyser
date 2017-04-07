class Document
  attr_accessor :words
  attr_accessor :klass

  def initialize klass: , path:
    @words = process_file(path)
    @klass = klass
  end

  def process_file path
    TextProcessor.new(path)
      .eliminate_punctuation
      .eliminate_stop_words
      .to_vec
  end

  def classified_klass
    @classified_klass ||= Classifier.instance.classify_doc(self)
  end

  def is_correct_classified?
    classified_klass == klass
  end

  def score
    is_correct_classified? ? 1 : 0
  end
end
