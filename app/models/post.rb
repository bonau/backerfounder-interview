class Post < ApplicationRecord
    belongs_to :user
    has_ancestry
    has_many :upvotes

    def liked_by_user?(user)
        self.upvotes.where(user: user).size > 0
    end

    def self.update_weight
        Post.all.each do |post|
            post.update(weight: (post.upvotes.size - 1) / ((Time.zone.now - post.created_at) ** 2))
        end
    end
end
