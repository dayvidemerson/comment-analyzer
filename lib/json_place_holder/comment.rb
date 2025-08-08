module JsonPlaceHolder
  class Comment < Base
    class << self
      def all
        get("/comments")
      end

      def find(id)
        response = get("/comments/#{id}")
        return response if response.present?

        raise JsonPlaceHolder::Error, "Comentário com ID #{id} não encontrado"
      end

      def where(post_id:)
        get("/posts/#{post_id}/comments")
      end
    end
  end
end
