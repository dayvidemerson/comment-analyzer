class Importer
  class User < Importer
    after_save :import_posts, if: :completed?

    def process!
      user_data = JsonPlaceHolder::User.where(username: key).first

      return if user_data.blank?

      transaction do
        company = Company.create!(
          name: user_data["company"]["name"],
          catch_phrase: user_data["company"]["catchPhrase"],
          bs: user_data["company"]["bs"]
        )

        address = Address.create!(
          street: user_data["address"]["street"],
          suite: user_data["address"]["suite"],
          city: user_data["address"]["city"],
          zipcode: user_data["address"]["zipcode"],
          latitude: user_data["address"]["geo"]["lat"],
          longitude: user_data["address"]["geo"]["lng"]
        )

        ::User.create!(
          name: user_data["name"],
          username: user_data["username"],
          email: user_data["email"],
          phone: user_data["phone"],
          website: user_data["website"],
          external_id: user_data["id"],
          company:,
          address:
        )
      end
    end

    private

    def import_posts
      user = ::User.find_by(username: key)

      Importer::Post.create!(key: user.external_id) if user.present?
    end
  end
end
