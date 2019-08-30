# frozen_string_literal: true

require "bootstrap-will_paginate/config/initializers/will_paginate.rb"

module StandardView
  class Engine < ::Rails::Engine
    isolate_namespace StandardView

    config.to_prepare do
      ApplicationController.helper(StandardView::ApplicationHelper)
      ApplicationController.helper(StandardView::FormattingHelper)
      ApplicationController.helper(StandardView::MastheadHelper)
    end
  end
end
