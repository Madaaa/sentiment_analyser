class Examples
  attr_accessor :positve_data
  attr_accessor :negative_data
  attr_accessor :size

  def initialize pos_doc_paths:, neg_doc_paths:
    @positve_data = KlassExamples.new klass: 1, doc_paths: pos_doc_paths
    @negative_data =  KlassExamples.new klass: 0, doc_paths: neg_doc_paths
    @size = positve_data.size + negative_data.size
  end

  def positive_text_probability
    @post_text_prob ||= positve_data.size/size.to_f
  end

  def negative_text_probability
    @neg_text_prob ||= negative_data.size/size.to_f
  end

  def all
    positve_data.docs + negative_data.docs
  end

  def uniq_words
    @uniq_words ||= (positve_data.words + negative_data.words).uniq
  end

  def words_probability data
    uniq_words.inject({}) do |acc, word|
      acc[word] = (1 + BigDecimal.new(data.words_frequency[word] || 0))/(uniq_words.size + data.nr_of_words).to_f
      acc
    end
  end

  def positive_words_probability
    @pos_words_prob ||= words_probability positve_data
  end

  def negative_words_probability
    @neg_words_prob ||= words_probability negative_data
  end
end
