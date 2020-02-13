# Tutorial for Mailer: https://launchschool.com/blog/handling-emails-in-rails
# Rails 4.2 Mailer tutorial: https://guides.rubyonrails.org/v4.2/action_mailer_basics.html#mailer-testing

class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(user, order)
    @user = user
    mail(to: @user.email, subject: "Jungle Order ##{order.id}")
  end
end
