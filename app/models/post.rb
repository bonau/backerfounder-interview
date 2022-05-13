class Post < ApplicationRecord
    belongs_to :user
    has_ancestry
    has_many :upvotes

    def liked_by_user?(user)
        self.upvotes.where(user: user).size > 0
    end
end
