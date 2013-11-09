class Purchase < ActiveRecord::Base
	attr_accessible :plan_id, :user_id, :stripe_card_token
  belongs_to :plan
  belongs_to :user

  validates :plan_id, presence: true
  validates :user_id, presence: true

  attr_accessor :stripe_card_token

  def save_with_payment
  	if valid?
  		customer = Stripe::Customer.create(description: user_id, 
                                         #email: @email,
                                         card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!

      charge = Stripe::Charge.create(amount: (plan.price * 100).to_i,
                                     currency: "usd",
                                     #customer: stripe_customer_token
                                     customer: customer.id)
  	end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
