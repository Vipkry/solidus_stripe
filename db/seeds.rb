# frozen_string_literal: true

secret_key = ENV['STRIPE_SEEDS_SECRET_KEY']
publishable_key = ENV['STRIPE_SEEDS_PUBLISHABLE_KEY']

puts "Loading seed: solidus_stripe/stripe_payment_method"

if secret_key.blank? || publishable_key.blank?
  puts "Failure: You have to set both STRIPE_SEEDS_SECRET_KEY and STRIPE_SEEDS_PUBLISHABLE_KEY environment variables."
else
  stripe_payment_method = Spree::PaymentMethod::StripeCreditCard.new do |gateway|
    gateway.name = 'Credit Card'
    gateway.preferred_server = "test"
    gateway.preferred_test_mode = true
    gateway.preferred_secret_key = secret_key
    gateway.preferred_publishable_key = publishable_key
  end

  if stripe_payment_method.save
    puts "Stripe Payment Method correctly created."
  else
    puts "There was some problems with creating Stripe Payment Method:"
    stripe_payment_method.errors.full_messages.each do |error|
      puts error
    end
  end
end
