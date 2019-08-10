# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def icon_for(key, spin: false)
      localization_key = "icons.#{key}"
      definition = I18n.t(localization_key) if I18n.exists?(localization_key)

      if definition.respond_to?(:fetch)
        name = definition.fetch(:name, "question")
        style = definition.fetch(:style, "s")
      else
        name = definition
      end

      name ||= "question"
      style ||= "s"

      content_tag(:i, "", class: "fa#{style} fa-#{name} #{"fa-spin" if spin}")
    end
  end
end
