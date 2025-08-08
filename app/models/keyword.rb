class Keyword < ApplicationRecord
  before_validation :format_word

  private

  def format_word
    self.word = I18n.transliterate(word.downcase) if word.present?
  end
end
