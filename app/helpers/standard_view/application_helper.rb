# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def action
      ActiveSupport::StringInquirer.new action_name
    end

    def active_for(*arguments)
      "active" if current_page?(*arguments)
    end

    def icon_for(reference, spin: false)
      definition = reference.icon if reference.respond_to?(:icon)
      definition ||= reference.to_h if reference.respond_to?(:to_h)
      definition ||= I18n.t("icons.#{reference}")
      definition ||= reference

      definition = { name: definition } if definition.present? && !definition.respond_to?(:fetch)

      icon_tag(definition[:name], definition[:style], spin: spin)
    end

    def icon_tag(name = null, style = null, spin: false)
      content_tag(:i, "", class: "fa#{style || "s"} fa-#{name || "question"} #{"fa-spin" if spin}")
    end
  end
end
