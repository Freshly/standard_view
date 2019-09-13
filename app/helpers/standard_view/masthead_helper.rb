# frozen_string_literal: true

module StandardView
  module MastheadHelper
    def masthead_nav_link_for_model(model_class)
      list = Material::List.for(model_class)
      masthead_nav_link list.item_class, list.list_title, active_for(controller: material.route_key)
    end

    def masthead_menu_link_for_model(model_class)
      list = Material::List.for(model_class)
      masthead_menu_link list.item_class, list.icon, list.list_title, active_for(controller: material.route_key)
    end

    def masthead_nav_link(destination, text, class_name = nil)
      link_to(destination, class: "nav-item nav-link #{class_name}") { text }
    end

    def masthead_menu_link(destination, icon_type, text, class_name = nil)
      link_to(destination, class: "dropdown-item #{class_name}") { "#{icon_for(icon_type)} #{text}".html_safe }
    end
  end
end
