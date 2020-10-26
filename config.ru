# This file is used by Rack-based servers to start the application.
require 'grape-active_model_serializers'
require_relative 'config/environment'

run Rails.application
