class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :workshop

  after_create :update_remaining_sits

  def update_remaining_sits
    workshop.update(remaining_sits: workshop.total_sit - workshop.no_of_tickets)
  end
end
