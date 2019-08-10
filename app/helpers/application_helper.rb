# frozen_string_literal: true

module ApplicationHelper
  def icon_for(key, spin: false)
    localization_key = "application.icons.#{key}"
    definition = I18n.exists?(localization_key) ? I18n.t(localization_key) : { style: :s, name: :question }
    # definition = FONTAWESOME_ICONS.fetch(key, MISSING_ICON)
    # content_tag(:i, "", class: "fa#{definition[:style]} fa-#{definition[:name]} #{"fa-spin" if spin}")
    definition
  end
end
