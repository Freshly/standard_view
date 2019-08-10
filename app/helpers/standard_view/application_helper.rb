# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def icon_for(key, spin: false)
      definition = if key.respond_to?(:icon)
        key.icon
      else
        localization_key = "icons.#{key}"
        I18n.t(localization_key)  if I18n.exists?(localization_key)
      end

      if definition.respond_to?(:fetch)
        name = definition.fetch(:name, )
        style = definition.fetch(:style, "s")
      else
        name = definition
      end

      content_tag(:i, "", class: "fa#{style || "s"} fa-#{name || "question"} #{"fa-spin" if spin}")
    end
  end
end
