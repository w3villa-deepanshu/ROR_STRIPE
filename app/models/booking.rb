class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :workshop
  validates :order_number ,presence: true,uniqueness:true


  before_validation :genrate_order_number
  after_create :update_remaining_sits

  def update_remaining_sits
    workshop.update(remaining_sits: workshop.total_sit - no_of_tickets)
  end
end

def genrate_order_number
  self.order_number = "Booking-#{SecureRandom.hex(5).upcase}"
end
