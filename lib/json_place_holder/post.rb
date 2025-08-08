module JsonPlaceHolder
  class Post < Base
    class << self
      def all
        get("/posts")
      end

      def find(id)
        response = get("/posts/#{id}")
        return response if response.present?

        raise JsonPlaceHolder::Error, "Postagem com ID #{id} não encontrada"
      end

      def where(user_id:)
        get("/users/#{user_id}/posts")
      end
    end
  end
end
