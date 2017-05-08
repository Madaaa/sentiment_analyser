class Accuracy
  def cross_validate pos_docs_path: 'app/data/pos/*', neg_docs_path: 'app/data/neg/*'
    postive_docs = Dir[pos_docs_path]
    negative_docs = Dir[neg_docs_path]

    (0..9).to_a.map do |it|
      pos_test_examples = postive_docs[(it * 100)..(it * 100 + 99)]
      pos_train_examples = postive_docs - pos_test_examples 
      neg_test_examples = negative_docs[(it * 100)..(it * 100 + 99)]
      neg_train_examples = negative_docs - neg_test_examples
      params = {
        pos_docs_train: pos_train_examples, 
        pos_docs_test: pos_test_examples, 
        neg_docs_train: neg_train_examples, 
        neg_docs_test: neg_test_examples
      }
      Classifier.new(params).accuracy
    end
  end

  def value
    cross_validate.reduce(0.0, :+)/10
  end
end