# frozen_string_literal: true

# module ControllerHelpers
#   def sign_in(user)
#     if user.nil?
# allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {scope: :user})
#       allow(controller).to receive(:current_user).and_return(nil)
#     else
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(:current_user).and_return(user)
#     end
#   end
# end

# module DeviseRequestSpecHelpers

#   include Warden::Test::Helpers

#   def sign_in(resource_or_scope, resource = nil)
#     resource ||= resource_or_scope
#     scope = Devise::Mapping.find_scope!(resource_or_scope)
#     login_as(resource, scope: scope)
#   end

#   def sign_out(resource_or_scope)
#     scope = Devise::Mapping.find_scope!(resource_or_scope)
#     logout(scope)
#   end

# end
