# frozen_string_literal: true

module StandardView
  class Engine < ::Rails::Engine
    isolate_namespace StandardView

    config.to_prepare do
      ApplicationController.helper(StandardView::ApplicationHelper)
    end
  end
end
