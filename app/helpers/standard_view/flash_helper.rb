# frozen_string_literal: true

module StandardView
  module FlashHelper
    ALERT_CLASSES_BY_FLASH_TYPE = {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info",
    }.freeze

    def alert_class_for_flash(flash_type)
      ALERT_CLASSES_BY_FLASH_TYPE.fetch(flash_type.to_sym, flash_type.to_s)
    end
  end
end
