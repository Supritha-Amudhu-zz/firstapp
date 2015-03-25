class Micropost < ActiveRecord::Base
	belongs_to :user
	validates_length_of :content, :maximum => 140
	validates_length_of :user_id, :maximum => 20

end
