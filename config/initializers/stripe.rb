if Rails.env.development?
	STRIPE_PUBLIC_KEY = "pk_test_TogoxlRgEzPQLKEewF3NQo3R"
	STRIPE_SECRET_KEY = "sk_test_2Mu3VjvPLeai1szaQXFHXIRB"
else
	STRIPE_PUBLIC_KEY = "pk_live_iA2jP5XxBwS7P0GiOMXSZ1Uh"
	STRIPE_SECRET_KEY = "sk_live_fGVAJDd6s7h2UNYqIefUFvy7"
end

Stripe.api_key = STRIPE_SECRET_KEY

#Rails.configuration.stripe = {
#  :publishable_key => ENV['STRIPE_PUBLIC_KEY'],
#  :secret_key      => ENV['STRIPE_SECRET_KEY']
#}

#Stripe.api_key = Rails.configuration.stripe[:secret_key]