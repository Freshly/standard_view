# frozen_string_literal: true

module StandardView
  module FormattingHelper
    def title_for_collection(collection)
      title_for_model(collection.model)
    end

    def title_for_model(model)
      heading_for_model(model).pluralize
    end

    def heading_for_model(model)
      model.model_name.human.titleize
    end

    def color_square(color, size: "24px")
      content_tag(:div, "", title: color, style: "width: #{size}; height: #{size}; background: #{color}")
    end
  end
end
