class Importer
  class Comment < Importer
    def process!
      comments = JsonPlaceHolder::Comment.where(post_id: key)

      return if comments.blank?

      post = ::Post.find_by(external_id: key)

      transaction do
        comments_data =
          comments.map do |comment_data|
            {
              name: comment_data["name"],
              email: comment_data["email"],
              body: comment_data["body"],
              external_id: comment_data["id"]
            }
          end

        post.comments.create!(comments_data)
      end
    end
  end
end
