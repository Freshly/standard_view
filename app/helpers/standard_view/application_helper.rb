# frozen_string_literal: true

module StandardView
  module ApplicationHelper
    def action
      ActiveSupport::StringInquirer.new action_name
    end

    def actionable_name
      return "new" if action_name == "create"
      return "edit" if action_name == "update"

      action_name
    end

    def active_for(**options)
      "active" if on_page?(options)
    end

    def on_page?(check_parameters: false, **options)
      current_page?(options, check_parameters: check_parameters)
    rescue ActionController::UrlGenerationError
      false
    end

    def icon_for(reference, spin: false)
      reference = reference.icon if reference.respond_to?(:icon)
      definition = icon_definition_for_reference(reference)
      icon_tag(definition[:name], definition[:style], spin: spin)
    end

    def icon_definition_for_reference(reference)
      definition = reference.to_h if reference.respond_to?(:to_h)
      definition ||= I18n.t("icons.#{reference}", default: nil) || reference if reference.present?
      definition ||= {}
      definition = { name: definition } if definition.present? && !definition.respond_to?(:fetch)
      definition
    end

    def current_page
      params[:page].try(:to_i)
    end

    def icon_tag(name = nil, style = nil, spin: false)
      content_tag(:i, "", class: "fa#{style || "s"} fa-#{name || "question"} #{"fa-spin" if spin}")
    end

    def link_to_destroy_with_confirmation_for_record(record, extra_classes: "")
      link_to t("common.destroy"),
              record,
              class: "btn btn-danger #{extra_classes}",
              method: :delete,
              data: { confirm: t("common.confirm_destroy") }
    end

    def attribute_value_for(material, attribute_name)
      formatted_method_name = "#{attribute_name}_formatted"
      return material.public_send(formatted_method_name) if material.respond_to?(formatted_method_name)

      return material.public_send(attribute_name) if material.class.try(:primary_key) == attribute_name
      return link_to_related(material, attribute_name) if material.relationship_attributes.include?(attribute_name)

      i18n_method_name = "#{attribute_name}_i18n"
      return material.public_send(i18n_method_name) if material.respond_to?(i18n_method_name)

      material.human_attribute_value(attribute_name)
    end

    def link_to_related(material, attribute_name)
      related_object_method_name = attribute_name.chomp("_id")
      related_object = material.public_send(related_object_method_name)
      return if related_object.blank?

      related_material = Material::Base.for(related_object)
      link_to related_material.reference_title, related_material
    end

    def record_from_parent_route
      path_parent_name, path_parent_id = request.path.split("/#{controller_name}")&.first&.split("/").try(:[],1,2)
      return if path_parent_name.blank? || path_parent_id.blank?

      parent_name = path_parent_name.singularize
      parent_param_key = "#{parent_name}_id"
      parent_id = params[parent_param_key]
      parent_name.camelize.constantize.find(parent_id) if parent_id.present? && parent_id.to_s == path_parent_id
    end
  end
end
