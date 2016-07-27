class StaticPagesController < ApplicationController
  def home
    load_data_size
  end

  private
  def load_data_size
    objects = ["user", "course", "subject", "activity"]
    objects.each do |object|
      size = "#{object.capitalize}".constantize.all.size
      instance_variable_set "@#{object}_size", size
    end
  end
end
