class Classifier
  attr_accessor :train_examples
  attr_accessor :test_examples

  def initialize pos_docs_train:, pos_docs_test:, neg_docs_train:, neg_docs_test:
    @train_examples = Examples.new pos_doc_paths: pos_docs_train, neg_doc_paths: neg_docs_train
    @test_examples = Examples.new pos_doc_paths: pos_docs_test, neg_doc_paths: neg_docs_test
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
    test_examples.all.inject(0) do |acc, doc|
      classified_klass = classify_doc doc 
      score = doc.klass == classified_klass ? 1 : 0 
      acc += score
   end
  end
end
