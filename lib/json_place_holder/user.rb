module JsonPlaceHolder
  class User < Base
    class << self
      def all
        get("/users")
      end

      def find(id)
        response = get("/users/#{id}")
        return response if response.present?

        raise JsonPlaceHolder::Error, "Usuário com ID #{id} não encontrado"
      end

      def where(username:)
        get("/users?username=" + username)
      end
    end
  end
end
