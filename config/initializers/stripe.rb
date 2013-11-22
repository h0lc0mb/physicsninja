STRIPE_PUBLIC_KEY = "pk_test_TogoxlRgEzPQLKEewF3NQo3R"
STRIPE_SECRET_KEY = "sk_test_2Mu3VjvPLeai1szaQXFHXIRB"

Stripe.api_key = STRIPE_SECRET_KEY

#Rails.configuration.stripe = {
#  :publishable_key => ENV['STRIPE_PUBLIC_KEY'],
#  :secret_key      => ENV['STRIPE_SECRET_KEY']
#}

#Stripe.api_key = Rails.configuration.stripe[:secret_key]