class User < ActiveRecord::Base
  has_secure_password
  has_many :messages_sent, class_name: 'Message', foreign_key: :sender_id
  has_many :recipients, -> { select('users.*, messages.content') }, through: :messages_sent, source: :recipient
  has_many :messages_received, class_name: 'Message', foreign_key: :recipient_id
  has_many :senders, -> { select('users.*, messages.content') }, through: :messages_received, source: :sender
end

    # this refers to a user following many users
    # has_many :follower_follows, class_name: 'Follow', foreign_key: :followed_user_id

    # this is inverse of previous line
    # has_many :followers, through: :follower_follows, source: :follower_user


    # This refers to a user being followed by many users
    # has_many :followed_follows, class_name: 'Follow', foreign_key: :follower_user_id

    # This is inverse of above
    # has_many :following, through: :followed_follows, source: :followed_user
