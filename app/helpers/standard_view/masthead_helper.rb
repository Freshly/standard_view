# frozen_string_literal: true

module StandardView
  module MastheadHelper
    def masthead_nav_link_for_model(model_class)
      masthead_nav_link model_class,
                        title_for_model(model_class),
                        active_for(controller: model_class.name.pluralize.underscore)
    end

    def masthead_menu_link_for_model(model_class)
      masthead_menu_link model_class,
                         model_class.model_name.singular.to_sym,
                         title_for_model(model_class),
                         active_for(controller: model_class.name.pluralize.underscore)
    end

    def masthead_nav_link(destination, text, class_name = nil)
      link_to(destination, class: "nav-item nav-link #{class_name}") { text }
    end

    def masthead_menu_link(destination, icon_type, text, class_name = nil)
      link_to(destination, class: "dropdown-item #{class_name}") { "#{icon_for(icon_type)} #{text}".html_safe }
    end
  end
end
