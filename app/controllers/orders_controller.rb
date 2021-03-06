
class OrdersController < ApplicationController
  # before_filter :authorize

  def show
    @order = Order.find(params[:id])

    line_items = LineItem.where(order_id: @order[:id])

    product_ids = line_items.map { |item| item[:product_id] }
    products = Product.where(id: product_ids)

    @email = current_user.email unless current_user.nil?

    @order_items = line_items.map do |item|
      {
        product: products.select { |product| product[:id] == item[:product_id] }[0],
        item_price_cents: item.item_price_cents,
        total_price_cents: item.total_price_cents,
      }
    end
  end

  def create
    charge = perform_stripe_charge
    order = create_order(charge)

    if order.valid?
      empty_cart!
      UserMailer.order_email(current_user, order).deliver_now unless current_user.nil?
      redirect_to order, flash: { Notice: "Your Order has been placed." }
    else
      redirect_to cart_path, flash: { error: "Error creating order." }
    end
  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source: params[:stripeToken],
      amount: cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency: "cad",
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity,
      )
    end
    order.save!
    order
  end
end
