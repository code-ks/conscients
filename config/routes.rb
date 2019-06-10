# frozen_string_literal: true

Rails.application.routes.draw do
  # noise
  respond200 = ['wp-login.php']
  respond200.each do |r2|
    get "/#{r2}", to: proc { [200, {}, ['']] }
    post "/#{r2}", to: proc { [200, {}, ['']] }
  end
  redirect_root = ['login.aspx']
  redirect_root.each do |rr|
    get "/#{rr}", to: redirect('/')
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :clients, only: :omniauth_callbacks,
  controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'
    devise_for :clients, skip: :omniauth_callbacks,
               controllers: { registrations: 'clients/registrations' }

    # Blog posts are not managed in the normal Active Admin interface
    # because of the specific rich text editors
    namespace :admin do
      resources :blog_posts
    end
    resources :blog_posts, only: %i[index show]
    resources :contacts, only: :create
    resources :newsletter_subscriptions, only: :create
    resource :clients, only: :show
    resources :categories, only: [] do
      resources :products, only: :index
    end
    resources :products, only: :show do
      resources :line_items, only: %i[create update destroy]
    end
    resource :invoices, only: [] do
      scope module: :invoices do
        resources :downloads, only: :new
      end
    end
    resource :certificates, only: [] do
      scope module: :certificates do
        resources :downloads, only: :new
      end
    end
    resource :klm_files, only: [] do
      scope module: :klm_files do
        resources :downloads, only: :new
      end
    end
    # Routes for the checkout process --> Cart leads to deliveries choice leads to payments
    scope module: :checkout do
      resources :carts, only: :show
      resources :deliveries, only: %i[new create]
      resources :payments, only: %i[new show] do
        collection do
          post 'create_stripe'
          post 'create_paypal'
          post 'create_bank_transfer'
          get 'paypal_success'
        end
      end
      resources :coupon_to_order_additions, only: :create
    end

    # permanent redirections
    get '/conscients-chez-lilli-bulle', to: redirect(
      '/', status: 301
    )
    get '/shop/fr/cadeau-arbre/22-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/fr/12-cadeau-arbre', to: redirect(
      '/categories/offrir-un-arbre-cadeau/products', status: 301
    )
    get '/shop/fr/14-cadeau-bebe-bio', to: redirect(
      '/categories/cadeau-bebe-bio-ecolo-vetement-bio-b%C3%A9b%C3%A9/products', status: 301
    )
    get '/shop/fr/13-cadeau-naissance-bio', to: redirect(
      '/categories/cadeau-naissance-bio-%C3%A9quitable-original/products', status: 301
    )
    get '/shop/fr/7-vetements-bio-bebe-fille', to: redirect(
      '/categories/vetement-bebe-fille-coton-bio/products', status: 301
    )
    get '/shop/fr/11-vetements-bio-bebe-garcon', to: redirect(
      '/categories/vetement-bio-bebe-garcon/products', status: 301
    )
    get '/mytreeshirt', to: redirect(
      '/categories/idee-cadeau-ecolo-bio-bebe-femme-homme/products', status: 301
    )
    get '/shop/fr/cadeau-arbre/64-album-illustre-jeunesse-foret-tropicale.html', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/fr/cadeau-arbre/69-coffret-cadeau-naissance-bio-equitable-personnalise-my-tree-shirt-super-yoghiros.html', to: redirect(
      '/products/cadeau-naissance-bio-tree-shirt-yoghiros-rose', status: 301
    )
    get '/shop/fr/cadeau-bebe-bio/68-cadeau-bebe-bio-personnalise-avec-prenom-et-date-de-naissance-my-tree-shirt.html', to: redirect(
      '/products/cadeau-naissance-bio-tree-shirt-yoghiros-bleu', status: 301
    )
    get '/shop/fr/cadeau-bebe-bio/70-bebe-bio-cadeau-vetement-bio-luxe-naissance-coton-bio-my-tree-shirt.html', to: redirect(
      '/products/cadeau-naissance-bio-tree-shirt-yoghiros-camel', status: 301
    )
    # permanent redirections sitemap
    get '/shop/en/sitemap', to: redirect(
      '/site_map', status: 301
    )
    get '/sitemap', to: redirect(
      '/site_map', status: 301
    )

    # permanent redirections bapteme
    get '/shop/62-356-thickbox/arbre-cadeau-bapteme.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-357-thickbox/arbre-cadeau-bapteme-fille-garcon-parrain-marraine.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/idees-cadeaux-pour-les-invites-dun-bapteme/', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/en/a-tree-for-baby/62-arbre-cadeau-bapteme.html', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-355-thickbox/arbre-cadeau-bapteme-fille-garcon-parrain-marraine.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/wp-content/uploads/2016/02/arbres-cadeaux-pour-les-invites-d-un-bapteme.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-356-thickbox/arbre-cadeau-bapteme-fille-garcon-parrain-marraine.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-357-thickbox/arbre-cadeau-bapteme.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/wp-content/uploads/2016/02/foret-en-cadeau-bapteme-a-offrir-aux-invites.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-355-thickbox/arbre-cadeau-bapteme.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/wp-content/uploads/2016/02/Idee-cadeau-invite-bapteme-arbres.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/idees-cadeaux-pour-les-invites-dun-bapteme/feed/', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/62-356-large/arbre-cadeau-bapteme-fille-garcon-parrain-marraine.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/shop/fr/cadeau-arbre/62-arbre-cadeau-bapteme-fille-garcon-parrain-marraine.html', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/wp-content/uploads/2016/02/cadeau-invit%C3%A9-bapteme-personnalis%C3%A91.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )
    get '/wp-content/uploads/2016/02/idee-cadeau-bapteme-original-invites1.jpg', to: redirect(
      '/categories/Offrir-un-arbre-pour-un-bapteme-ecolo/products', status: 301
    )

    # permanent redirections mariage
    get '/shop/63-361-thickbox/arbre-cadeau-mariage-ecolo-chic.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-358-large/arbre-cadeau-mariage-ecolo-chic.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-360-thickbox/arbre-cadeau-mariage-ecolo.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/60-345-thickbox/offrir-un-arbre-pour-un-mariage-avec-un-mot-doux.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/en/a-tree-for-baby/63-arbre-cadeau-mariage-ecolo.html', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/fr/cadeau-arbre/63-arbre-cadeau-mariage-ecolo-chic.html', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-358-thickbox/arbre-cadeau-mariage-ecolo.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-359-thickbox/arbre-cadeau-mariage-ecolo.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-362-thickbox/arbre-cadeau-mariage-ecolo-chic.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-360-thickbox/arbre-cadeau-mariage-ecolo-chic.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-358-thickbox/arbre-cadeau-mariage-ecolo-chic.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/63-361-thickbox/arbre-cadeau-mariage-ecolo.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )
    get '/shop/60-345-large/offrir-un-arbre-pour-un-mariage-avec-un-mot-doux.jpg', to: redirect(
      '/products/offrir-un-arbre-pour-un-mariage', status: 301
    )

    # permanent redirections arbre amazonie
    get '/shop/it/cadeau-arbre/60-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-128-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/fr/22-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-376-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-376-large/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-204-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/wp-content/uploads/2013/03/planter-un-arbre-reforestation-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-204-large/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-130-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-127-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/wp-content/uploads/2016/03/planter-un-arbre-amazonie-reserve-biosphere-unesco1.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-129-medium/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-130-medium/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/de/cadeau-arbre/60-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/wp-content/uploads/2013/03/planter-un-arbre-amazonie-perou.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-125-thickbox/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/it/22-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-127-medium/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/fr/cadeau-arbre/22-offrir-un-arbre-cadeau-amazonie.html', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/fr/cadeau-bebe-bio/Amazonie', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    get '/shop/22-376-medium/offrir-un-arbre-cadeau-amazonie.jpg', to: redirect(
      '/products/offrir-un-arbre-en-amazonie', status: 301
    )
    # permanent redirections arbre naissance
    get '/offrir-un-arbre-en-cadeau-pour-la-naissance-dun-bebe/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/feed/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-377-large/offrir-un-arbre-en-cadeau-de-naissance-personnalise-fille-garcon.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-378-thickbox/offrir-un-arbre-en-cadeau-de-naissance-personnalise-fille-garcon.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-377-large/offrir-un-arbre-pour-une-naissance.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-378-thickbox/offrir-un-arbre-pour-une-naissance.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-377-thickbox/offrir-un-arbre-en-cadeau-de-naissance-personnalise-fille-garcon.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/offrir-un-arbre-pour-une-naissance-amazonie/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/offrir-un-arbre-pour-une-naissance-geolocalisation/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/offrir-un-arbre-pour-une-naissance-conscients/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-379-thickbox/offrir-un-arbre-pour-une-naissance.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/offrir-un-arbre-pour-une-naissance-3/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/offrir-un-arbre-pour-une-naissance-amazonie-2/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-380-thickbox/offrir-un-arbre-en-cadeau-de-naissance-personnalise-fille-garcon.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/cadeau-naissance-original-bio-un-arbre-un-bebe/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-380-thickbox/offrir-un-arbre-pour-une-naissance.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/offrir-un-arbre-pour-une-naissance/?replytocom=436', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/shop/65-379-thickbox/offrir-un-arbre-en-cadeau-de-naissance-personnalise-fille-garcon.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/wp-content/uploads/2013/01/offrir-un-arbre-pour-une-naissance-en-amazonie-perou.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )
    get '/wp-content/uploads/2013/01/offrir-un-arbre-pour-une-naissance-en-amazonie-perou.jpg', to: redirect(
      '/products/offrir-un-arbre-en-cadeau-de-naissance', status: 301
    )

    # Permanent redirections Livre Yoghiros
    get '/feed/www.kisskissbankbank.com/les-super-yoghiros-en-amazonie-le-livre', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-370-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/cyril-dion-preface-super-yoghiros/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/les-super-yoghiros-preface-de-roland-gerard/www.kisskissbankbank.com/les-super-yoghiros-en-amazonie-le-livre', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-373-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/album-sur-la-foret-en-maternelle/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-371-thickbox/album-illustre-sur-la-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/wp-content/uploads/2016/04/Supers-yoghiros-francis-halle-album-for%C3%AAt-maternelle1-300x266.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/les-supers-yoghiros-preface-de-francis-halle/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/wp-content/uploads/2015/11/album-arbre-maternelle-amazonie-lila-poppins-conscients1.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-371-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/wp-content/uploads/2016/03/projet-foret-en-maternelle-grande-section-album-illustre.png', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/album-foret-maternelle-illustre-tests-couleurs/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/wp-content/uploads/2016/04/Supers-yoghiros-francis-halle-album-for%C3%AAt-maternelle1.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-372-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-369-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-363-thickbox/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-366-thickbox/album-illustre-sur-la-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/en/a-tree-for-baby/64-album-illustre-sur-la-foret-tropicale.html', to: redirect(
      '/en/products/les-super-yoghiros-book', status: 301
    )
    get '/wp-content/uploads/2012/08/album-illustre-foret-maternelle-gs-amazonie-conscients.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/album-sur-la-foret-en-maternelle/feed/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-373-medium/album-illustre-sur-la-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/les-super-yoghiros-preface-de-roland-gerard/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-366-large/album-illustre-sur-la-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/les-supers-yoghiros-lidee-de-depart/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/fr/cadeau-arbre/64-album-illustre-sur-la-foret-tropicale.html', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/lhistoire-de-vos-arbres/', to: redirect(
      '/categories/offrir-un-arbre-cadeau/products', status: 301
    )
    get '/rejoignez-les-super-yoghiros/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/wp-content/uploads/2016/03/album-jeunesse-theme-foret-tropicale1.png', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-369-thickbox/album-illustre-sur-la-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/les-supers-yoghiros-preface-de-francis-halle/feed/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/64-363-large/album-illustre-jeunesse-foret-tropicale.jpg', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    # get '/shop/fr/cadeau-arbre/64-album-illustre-jeunesse-foret-tropicale.html?code=phpinfo();', to: redirect(
    #   '/products/les-super-yoghiros', status: 301
    # )
    get '/wp-login.php?redirect_to=http://www.conscients.com/album-foret-maternelle-illustre-tests-couleurs/', to: redirect(
      '/products/les-super-yoghiros', status: 301
    )
    get '/shop/fr/*foo', to: redirect(
      '/', status: 301
    )
    resources :sitemap_tests, only: :index

    if Rails.env.production?
      get '*path', to: 'pages#home', constraints: lambda { |req|
        req.path.exclude? 'rails/active_storage'
      }
    end
  end
end
