# frozen_string_literal: true

class ProcessOrderJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    set_view
    update_order
    @order.generate_invoice
    generate_certificates
    send_order_confirmation
    send_gift_certificates
    @order.delivered! if @order.email?
  end

  private

  def set_view
    @view = ActionView::Base.new('app/views', {}, ActionController::Base.new)
    @view.extend(ApplicationHelper)
    @view.extend(Rails.application.routes.url_helpers)
  end

  def update_order
    @order.update(payment_date: Time.zone.now, total_price: @order.ttc_price_all_included,
                  delivery_fees: @order.current_delivery_fees)
  end

  def generate_invoice
    pdf = WickedPdf.new.pdf_from_string(
      @view.render(
        template: 'invoices/new',
        locals: { '@order': @order, '@delivery_address': @order.delivery_address,
                  '@billing_address': @order.billing_address },
        layout: 'layouts/pdf'
      )
    )
    @order.invoice.attach(io: StringIO.new(pdf), filename: "invoice##{@order.id}.pdf",
                          content_type: 'application/pdf')
  end

  def generate_certificates
    @order.line_items.each do |line_item|
      next unless line_item.tree?
      line_item.generate_certificate(@view)
    end
  end

  def send_order_confirmation
    ClientMailer.with(order: @order).order_confirmation.deliver_later
  end

  def send_gift_certificates
    @order.line_items.to_deliver_by_email.each do |line_item|
      RecipientMailer.with(line_item: line_item).gift_certificate.deliver_later
    end
  end
end
