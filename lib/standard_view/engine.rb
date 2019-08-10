# frozen_string_literal: true

module StandardView
  class Engine < ::Rails::Engine
    isolate_namespace StandardView

    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper StandardView::ApplicationHelper
      end
    end
  end
end
