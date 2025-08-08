class Comment < ApplicationRecord
  belongs_to :post

  after_create :schedule_translation

  def translate!
    translated_name = LibreTranslate.translate(text: name)
    translated_body = LibreTranslate.translate(text: body)

    update!(translated_name:, translated_body:)
  end

  def calculate!
    words = (translated_name.downcase.split + translated_body.downcase.split).uniq

    words = words.map do |word|
      I18n.transliterate(word.gsub(/[^a-zA-Z0-9]/, ''))
    end

    update!(rating: Keyword.where('word in (?)', words).size)
  end

  def status
    return 'pending' unless rating

    return 'rejected' if rating < 2
    
    'approved'
  end

  private

  def schedule_translation
    ProcessCommentJob.perform_later(id)
  end
end
