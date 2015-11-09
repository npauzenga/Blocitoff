class AuthenticatedController < ApplicationController
  before_action :log_in
end
