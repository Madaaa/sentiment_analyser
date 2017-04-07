class Classifier
  include Singleton

  attr_accessor :train_examples
  attr_accessor :test_examples

  def initialize pos_docs_path: 'app/data/pos/*', neg_docs_path: 'app/data/neg/*'
    postive_docs = Dir[pos_docs_path]
    negative_docs = Dir[neg_docs_path]

    @train_examples = Examples.new pos_doc_paths: postive_docs.first(700), neg_doc_paths: negative_docs.first(700)
    @test_examples = Examples.new pos_doc_paths: postive_docs.last(300), neg_doc_paths: negative_docs.last(300)
  end

  def classify_doc doc
    positive_prob = doc.words.inject(train_examples.positive_text_probability) do |acc,word|
      acc = acc * (train_examples.positive_words_probability[word] || 1)
    end

    negative_prob = doc.words.inject(train_examples.negative_text_probability) do |acc,word|
      acc = acc * (train_examples.negative_words_probability[word] || 1)
    end

    positive_prob > negative_prob ? 1 : 0
  end

  def accuracy
    BigDecimal.new(cross_validation) / (test_examples.size)
  end

  def cross_validation
    test_examples.all.inject(0) { |acc, doc| acc += doc.score  }
  end
end
