# frozen_string_literal: true

ActiveAdmin.register Product do
  menu parent: I18n.t('active_admin.product_management')

  config.sort_order = 'position_asc'

  permit_params :name_fr, :name_en, :description_short_fr, :description_short_en,
                :description_long_fr, :description_long_en,
                :ht_price_cents, :position, :position_home, :tax_rate, :weight, :product_type,
                :published, :ht_buying_price_cents, :seo_title_fr, :seo_title_en,
                :meta_description_fr, :meta_description_en, :keywords_fr, :keywords_en,
                :producer_latitude, :producer_longitude, :certificate_background,
                :background_image, :color_certificate, images: []

  includes :text_translations, :images_attachments, :certificate_background_attachment

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  # Custom action --> Link + simili controller
  action_item :remove_images, only: :show do
    link_to t('.remove_images'), remove_images_admin_product_path(product), method: :put
  end

  member_action :remove_images, method: :put do
    resource.images.purge
    redirect_to resource_path
  end

  index do
    selectable_column
    id_column
    column :name_fr
    column :name_en
    column :slug_fr
    column :slug_en
    column :description_short_fr
    column :description_short_en
    column :description_long_fr
    column :description_long_en
    column :images do |product|
      if product.images.attached?
        ul do
          product.images.each do |image|
            li image_tag(image, height: 50)
          end
        end
      end
    end
    column :published
    column :position
    column :position_home
    column :ht_price_cents
    column :ht_buying_price_cents
    column :tax_rate
    column :weight
    column :product_type
    column :seo_title_fr
    column :seo_title_en
    column :meta_description_fr
    column :meta_description_en
    column :keywords_fr
    column :keywords_en
    column :producer_latitude
    column :producer_longitude
    column :background_image do |product|
      image_tag(product.background_image, height: 200) if product.background_image.attached?
    end
    column :certificate_background do |product|
      if product.certificate_background.attached?
        image_tag(product.certificate_background, height: 200)
      end
    end
    column :color_certificate
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :name_fr
      f.input :name_en
      f.input :description_short_fr
      f.input :description_short_en
      f.input :description_long_fr, as: :text
      f.input :description_long_en, as: :text
      f.input :images, as: :file, input_html: { multiple: true },
              hint: if product.images.attached?
                      ul do
                        product.images.each do |image|
                          li image_tag(image, height: 50)
                        end
                      end
                    end
      f.input :published
      f.input :position
      f.input :position_home
      f.input :ht_price_cents
      f.input :ht_buying_price_cents
      f.input :tax_rate
      f.input :weight
      f.input :product_type
      f.input :seo_title_fr
      f.input :seo_title_en
      f.input :meta_description_fr
      f.input :meta_description_en
      f.input :keywords_fr
      f.input :keywords_en
      f.input :background_image, as: :file,
              hint: if product.background_image.attached?
                      image_tag(f.object.background_image, height: 200)
                    end
      f.input :certificate_background, as: :file,
              hint: if product.certificate_background.attached?
                      image_tag(f.object.certificate_background, height: 200)
                    end
      f.input :color_certificate
      f.input :producer_latitude
      f.input :producer_longitude
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name_fr
      row :name_en
      row :slug_fr
      row :slug_en
      row :description_short_fr
      row :description_short_en
      row :description_long_fr
      row :description_long_en
      row :images do |product|
        if product.images.attached?
          ul do
            product.images.each do |image|
              li image_tag(image, height: 50)
            end
          end
        end
      end
      row :published
      row :position
      row :position_home
      row :ht_price_cents
      row :ht_buying_price_cents
      row :tax_rate
      row :weight
      row :product_type
      row :seo_title_fr
      row :seo_title_en
      row :meta_description_fr
      row :meta_description_en
      row :keywords_fr
      row :keywords_en
      row :producer_latitude
      row :producer_longitude
      row :background_image do |product|
        image_tag(product.background_image, height: 200) if product.background_image.attached?
      end
      row :certificate_background do |product|
        if product.certificate_background.attached?
          image_tag(product.certificate_background, height: 200)
        end
      end
      row :color_certificate
      row :created_at
      row :updated_at
    end
  end
end
