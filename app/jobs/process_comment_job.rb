class ProcessCommentJob < ApplicationJob
  queue_as :default

  def perform(id)
    comment = Comment.find(id)

    comment.translate!
    comment.calculate!
  end
end
