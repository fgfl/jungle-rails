class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.admin_login[:name],
                               password: Rails.configuration.admin_login[:password]

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
  end

  def create
  end
end
