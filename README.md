# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

This was an inherited code base where we were given the task to fix some bugs and implement new features. New routes are created following a RESTful convention.

- Bug fixes:

  - Money formatting: unified money formatting accross the site
  - Missing admin security: require admin username and password to access admin pages

- UI change:

  - Display a message and link to home page if cart is empty instead of cart details with any data
  - Display a "Sold Out" badge for items with no inventory
  - Display details of the order after an order was placed successfully

- Features:

  - Add an admin dashboard with overview of the number of products and categories
  - Add an About page, that can be filled with data about the company
  - Add a new page for admins to create new categories
  - Add new databases and pages to support user login and registration
    - passwords are properly hashed with bcrypt
    - emails must be unique and are case insensitive

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

Enter a future date and any three digits for the CVC.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Ruby 2.3.5
- Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
- PostgreSQL 9.x
- Stripe

## Images

![Sign up as a new user](https://raw.githubusercontent.com/fgfl/jungle-rails/master/docs/signUP.gif)

Sign up as a new user.

![Add items to the cart and submit the order](https://raw.githubusercontent.com/fgfl/jungle-rails/master/docs/buy_sequence.gif)

Buy some items.

![Log in as an admin to perform admin commands](https://raw.githubusercontent.com/fgfl/jungle-rails/master/docs/admin.gif)

Log in as an admin and add a new category.
