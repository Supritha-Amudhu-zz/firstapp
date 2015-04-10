class Micropost < ActiveRecord::Base
	belongs_to :user
	validates_length_of :content, :maximum => 140
	validates_length_of :user_id, :maximum => 20

	attr_accessible :content, :user_id

	default_scope :order => 'created_at DESC'

end
