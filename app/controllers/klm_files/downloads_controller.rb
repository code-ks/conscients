# frozen_string_literal: true

class KlmFiles::DownloadsController < ApplicationController
  def new
    @tree_plantation = TreePlantation.find(params[:tree_plantation_id])
    send_data \
      @tree_plantation.klm_file.download,
      disposition: 'attachment',
      filename: "#{@tree_plantation.project_name}.klm"
  end
end
