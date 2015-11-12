class AuthenticatedController < ApplicationController
  before_action :log_in_required
end
