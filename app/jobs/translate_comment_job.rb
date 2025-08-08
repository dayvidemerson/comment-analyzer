class TranslateCommentJob < ApplicationJob
  queue_as :default

  def perform(id)
    comment = Comment.find(id)

    comment.translate!
  end
end
