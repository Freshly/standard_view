# frozen_string_literal: true

module StandardView
  module NavigationHelper
    def nav_item_overview_for_material(material)
      active_link_class = active_for(controller: material.route_key, action: :show)
      content_tag(:li, class: "nav-item") do
        link_to(t("common.overview"), material, class: "nav-link #{active_link_class}")
      end
    end

    def nav_item_nested_model_for_record(record, model, count_method = nil)
      nav_item_related_model_for_record(record, model, count_method, nested: true)
    end

    def nav_item_related_model_for_record(record, model, count_method = nil, nested: false)
      collection = model.model_name.collection
      count_method ||= begin
        default_count_method_name = "#{collection}_count".to_sym
        record.respond_to?(default_count_method_name) ? default_count_method_name : collection
      end

      link_target = [ collection, record ]
      link_target.reverse! if nested

      active_link_arguments = { controller: (nested ? model : record).model_name.collection }
      active_link_arguments[:action] = collection unless nested

      nav_item(
        link_target: link_target,
        icon: model.model_name.singular.to_sym,
        title: title_for_model(model),
        count: record.public_send(count_method.to_sym),
        active_class: active_for(**active_link_arguments),
      )
    end

    def nav_item(link_target:, icon:, title:, count:, active_class:)
      content_tag(:li, class: "nav-item") do
        link_to(link_target, class: "nav-link #{active_class}") do
          content_tag(:span) do
            concat icon_for(icon)
            concat "&nbsp;".html_safe
            concat title
            concat count_badge(count)
          end
        end
      end
    end
  end
end
