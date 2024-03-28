# frozen_string_literal: true

module ApplicationHelper
  def navigation_items
    [
      { body: 'Dashboard', href: root_path },
      { body: 'Start Workout Plan', href: workout_plans_path },
      { body: 'Contact Us', href: contact_us_path }
    ]
  end

  def navigation_class(path)
    if current_page?(path)
      'bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium'
    else
      'text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium'
    end
  end

  def navigation_aria(path)
    if current_page?(path)
      'page'
    else
      'false'
    end
  end

  def flash_classes(flash_type)
    flash_base = 'px-2 py-4 mx-auto font-sans font-medium text-center text-white'
    {
      notice: "bg-indigo-600 #{flash_base}",
      error: "bg-red-600 #{flash_base}",
      alert: "bg-red-600 #{flash_base}"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def profile_image
    current_user&.avatar_url || '/assets/user.png'
  end
end
