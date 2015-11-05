# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-/assets/application/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  pages/index.js
  application/owl.carousel.min.js
  application/jquery.bxslider.js
  libs/html5shiv/ie.js
  vendor/modernizr.js
  application/owl.carousel.min.js
  pages/career.js
  pages/index.js
  application/jquery.popupoverlay.js
  pages/services.js
  stub.css
  print.css
)
