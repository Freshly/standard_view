# frozen_string_literal: true

module StandardView
  class Engine < ::Rails::Engine
    isolate_namespace StandardView

    config.to_prepare do
      ApplicationController.helper(StandardView::ApplicationHelper)
      ApplicationController.helper(StandardView::FlashHelper)
      ApplicationController.helper(StandardView::FormattingHelper)
      ApplicationController.helper(StandardView::MastheadHelper)
      ApplicationController.helper(StandardView::BadgeHelper)
      ApplicationController.helper(StandardView::NavigationHelper)
    end
  end
end
