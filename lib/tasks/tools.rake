require Rails.root + 'config/environment'

namespace :tools do
  desc "update weight"
  task :update_weight do
    Post.update_weight
  end

  desc "generate users"
  task :generate_users, [:num] => :environment do |t, args|
    @counter = 0
    args[:num].to_i.times do |i|
      @counter += 1 if User.create(email: ("polarp%d@gmail.com" % i), password: 'peko1234!', password_confirmation: 'peko1234!') rescue next
    end
    STDERR.puts "%d users created" % args[:num]
  end

  desc "generate upvotes for post"
  task :generate_upvotes, [:post_id, :count] => :environment do |t, args|
    @counter = 0
    User.take(args[:count].to_i).each do |u|
      @counter += 1 if Post.find(args[:post_id].to_i).upvotes.where(user: u).first_or_create
    end
    STDERR.puts "%d upvotes for Post#%d created" % [@counter, args[:post_id]]
  end

  desc "generate fake posts"
  task :generate_posts, [:count] => :environment do |t, args|
    args[:count].to_i.times do |i|
      p Post.where(id: i).first_or_create(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph(sentence_count: 2),
        user: User.order('RANDOM()').take(1).first
      )
    end
  end
end
