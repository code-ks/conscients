# frozen_string_literal: true

ActiveAdmin.register Order do
  menu parent: I18n.t('i18n.order_management')

  permit_params :active_admin_requested_event

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    if event.present?
      # whitelist to ensure we don't run an arbitrary method
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbidden event #{event} requested on instance #{your_model.id}" unless safe_event
      # launch the event with bang
      order.send("#{safe_event}!")
    end
  end

  form do |f|
    # display current state as disabled to avoid modifying it directly
    f.input :aasm_state, input_html: { disabled: true }, label: 'Current state'

    # use the attr_accessor to pass the data
    f.input :active_admin_requested_event, label: 'Change state', as: :select,
            collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
