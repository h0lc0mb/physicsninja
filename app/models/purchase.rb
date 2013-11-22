class Purchase < ActiveRecord::Base
	attr_accessible :plan_id, :user_id, :stripe_card_token
  belongs_to :plan
  belongs_to :user

  validates :plan_id, presence: true
  validates :user_id, presence: true

  attr_accessor :stripe_card_token
  #include ActionView::Helpers

  def save_with_payment
  	if valid?
      #if user.stripe_customer_token.nil?
        #customer = Stripe::Customer.create(description: user_id, 
        #                                   email: user.email.to_s,
        #                                   card: stripe_card_token)
        #user.stripe_customer_token = customer.id
        #save!
      #end

      #charge = Stripe::Charge.create(amount: (plan.price * 100).to_i,
      #                               currency: "usd",
      #                               customer: user.stripe_customer_token)
      #save!

      charge = Stripe::Charge.create(amount: (plan.price * 100).to_i,
                                     currency: "usd",
                                     card: stripe_card_token,
                                     description: user.email.to_s)
      if user.q_balance.nil?
        new_balance = plan.questions
      else
        new_balance = [user.q_balance, plan.questions].sum
      end
      user.update_attribute(:q_balance, new_balance)
      save!
  	end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end