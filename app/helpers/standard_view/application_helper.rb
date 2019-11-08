# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def action
      ActiveSupport::StringInquirer.new action_name
    end

    def active_for(options = {})
      "active" if on_page?(options)
    end

    def on_page?(check_parameters: false, **options)
      current_page?(options, check_parameters: check_parameters)
    rescue ActionController::UrlGenerationError
      false
    end

    def icon_for(reference, spin: false)
      reference = reference.icon if reference.respond_to?(:icon)
      definition = if reference.nil?
        {}
      elsif reference.respond_to?(:to_h)
        reference.to_h
      else
        I18n.t("icons.#{reference}", default: nil) || reference
      end

      definition = { name: definition } if definition.present? && !definition.respond_to?(:fetch)

      icon_tag(definition[:name], definition[:style], spin: spin)
    end

    def current_page
      params[:page]
    end

    def icon_tag(name = nil, style = nil, spin: false)
      content_tag(:i, "", class: "fa#{style || "s"} fa-#{name || "question"} #{"fa-spin" if spin}")
    end
  end
end
