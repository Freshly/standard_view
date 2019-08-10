# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def icon_for(key, spin: false)
      localization_key = "icons.#{key}"
      definition = I18n.t(localization_key) if I18n.exists?(localization_key)
      style = definition.try(:[], "style") || "s"
      name = definition.try(:[], "name") || definition || "question"
      content_tag(:i, "", class: "fa#{style} fa-#{name} #{"fa-spin" if spin}")
    end
  end
end
