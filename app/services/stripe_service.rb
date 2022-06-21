require "stripe"
class StripeService
    def initialize()
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end


    def find_or_create_customer(customer)
        if customer.strip_customer_id.present?
            strip_customer = Stripe::Customer.retrieve(customer.strip_customer_id)
        else
            strip_customer = Stripe::Customer.create({
                name:customer.full_name,
                email:customer.email,
                phone:customer.contact_no
            })
            customer.update(strip_customer_id: strip_customer.id)
        end
        strip_customer
    end

    def create_card_token(params)
        Stripe::Token.create({
            card:{
                number: params[:card_number].to_s,
                exp_month: params[:exp_month],
                exp_year: params[:exp_year],
                cvc:params[:cvv]
            }
        })
    end
    def create_stripe_customer_card(params,strip_customer)
        token = create_card_token(params)
        Stripe::Customer.create_source(
            strip_customer.id,
            {source:token.id}
        )
    end


    def create_stripe_charge(amount_to_be_paid,strip_customer_id,card_id,workshop)
        Stripe::Charge.create({
            amount:amount_to_be_paid * 100,
            currency: 'usd',
            source:card_id,
            customer:strip_customer_id,
            description:"amount #{amount_to_be_paid} charged for #{workshop.name}"
        })
    end

    def create_stripe_refund(stripe_charge_id)
        Stripe::Refund.create({charge:stripe_charge_id})
    end

end