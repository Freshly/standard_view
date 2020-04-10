# frozen_string_literal: true

require "rails/generators/active_record/model/model_generator"

module Model
  class ModelGenerator < ActiveRecord::Generators::ModelGenerator
    source_root "#{base_root}/active_record/model/templates"

    class_option :material, type: :boolean, default: true
    hook_for :material, in: :material
  end
end
