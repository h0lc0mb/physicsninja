class Purchase < ActiveRecord::Base
	attr_accessible :plan_id, :user_id, :stripe_card_token
  belongs_to :plan
  belongs_to :user

  validates :plan_id, presence: true
  validates :user_id, presence: true
  #validates :amount, presence: true

  attr_accessor :stripe_card_token

  def save_with_payment
  	if valid?
      if user.stripe_customer_token.nil?
    		customer = Stripe::Customer.create(description: user_id, 
                                           email: user.email.to_s,
                                           card: stripe_card_token)
        user.stripe_customer_token = customer.id
        save!
      end

      charge = Stripe::Charge.create(amount: (plan.price * 100).to_i,
                                     currency: "usd",
                                     customer: user.stripe_customer_token)
      save!
  	end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_qbalance
    new_balance = self.user.q_balance + self.plan.questions
    self.user.update_attribute(:q_balance, new_balance)
  end
end