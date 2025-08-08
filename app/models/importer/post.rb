class Importer
  class Post < Importer
    after_save :import_comments, if: :completed?

    def process!
      posts = JsonPlaceHolder::Post.where(user_id: key)

      return if posts.blank?

      user = ::User.find_by(external_id: key)

      transaction do
        posts_data =
          posts.map do |post_data|
            {
              title: post_data["title"],
              body: post_data["body"],
              external_id: post_data["id"]
            }
          end

        user.posts.create!(posts_data)
      end
    end

    private

    def import_comments
      user = ::User.find_by(external_id: key)

      user.posts.pluck(:external_id).each do |external_id|
        Importer::Comment.create!(key: external_id)
      end
    end
  end
end
