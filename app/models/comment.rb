class Comment < ApplicationRecord
  belongs_to :post

  after_create :schedule_translation

  def translate!
    translated_body = LibreTranslate.translate(text: body)

    update!(translated_body:)
  end

  private

  def schedule_translation
    TranslateCommentJob.perform_later(id)
  end
end
