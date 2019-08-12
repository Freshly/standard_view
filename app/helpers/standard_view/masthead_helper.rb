# frozen_string_literal: true

module StandardView
  module MastheadHelper
    def masthead_nav_link_for_material(material)
      masthead_nav_link material.index_path, material.index_title, active_for(material.index_path)
    end

    def masthead_menu_link_for_material(material)
      masthead_menu_link material.index_path, material, material.index_title, active_for(material.index_path)
    end

    def masthead_nav_link(destination, text, class_name = nil)
      link_to(destination, class: "nav-item nav-link #{class_name}") { text }
    end

    def masthead_menu_link(destination, icon_type, text, class_name = nil)
      link_to(destination, class: "dropdown-item #{class_name}") { "#{icon_for(icon_type)} #{text}".html_safe }
    end
  end
end
