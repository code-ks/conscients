# frozen_string_literal: true

class Certificates::DownloadsController < ApplicationController
  def new
    @line_item = LineItem.find(params[:line_item_id])
    send_data(@line_item.certificate.download, disposition: 'attachment',
              filename: "certificate##{@line_item.id}.pdf")
  end
end
