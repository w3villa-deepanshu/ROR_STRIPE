class Workshop < ApplicationRecord
	extend FriendlyId
  	friendly_id :name, use: :slugged

	has_many :bookings
	has_many :customers ,through: :bookings


	validates :name ,:description ,:start_date,:end_date,:start_time,:end_time ,presence: true
	validates :total_sit ,:registration_fees ,presence: true,numericality: true
	validates :end_date ,comparison: { greater_than: :start_date, message:"can't be start before end_date"}

	scope :upcoming_workshop, -> { where('start_date > ?',Date.today) }
	scope :past_workshop, -> { where('end_date < ?',Date.today) }


	def total_duration
		"from #{start_date} to #{end_date}"
	end

	def daily_workshop_hour
		"#{((start_time.to_time - end_time.to_time)/1.hours).abs}Hours"
	end

	def daily_duration
		"EveryDay #{start_time} to #{end_time} (#{daily_workshop_hour})"
	end

	def is_upcoming_workshop?
		start_date > Date.today
	end

end
