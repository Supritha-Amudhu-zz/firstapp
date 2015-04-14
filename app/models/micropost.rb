class Micropost < ActiveRecord::Base
	belongs_to :user
	validates_length_of :content, :maximum => 140
	validates_length_of :user_id, :maximum => 20

	attr_accessible :content, :user_id

	default_scope :order => 'created_at DESC'

	named_scope :from_users_followed_by, lambda { |user| followed_by(user) }

	def self.from_users_followed_by(user)
		followed_ids = user.following.map(&:id)
		followed_ids << user.id
		all(:conditions => ["user_id IN (?)", followed_ids])
	end

	private

	def self.followed_by(user)
		followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
		{ :conditions => ["user_id IN (#{followed_ids}) OR user_id = :user_id", { :user_id => user}] }
	end

end
