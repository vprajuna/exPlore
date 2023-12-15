class Place < ApplicationRecord
	validates :business_id, presence: true
end
