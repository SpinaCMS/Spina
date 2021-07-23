# Caching Uploads

Spina CMS uses Rails' built-in Active Storage to handle file uploads. This means that setting up Active Storage is enough to get started with images and attachments in Spina.

By default, Active Storage generates signed, single-use URLs for images and files. Most websites are public however, so in most cases it's better to make blobs publicly accessible. You can do that by adding `public: true` to your app's `config/storage.yml`.

## Using a CDN

It's highly recommended to use CDN for your website. It will dramatically improve the performance of your Spina CMS project. The default Active Storage strategy in Rails makes it hard to cache files and images using a CDN. Luckily, as of Rails 6.1 this can be fixed using a new config:

```
# config/environments/production.rb
# ...
config.active_storage.resolve_model_to_route = :rails_storage_proxy
```

By default, Active Storage generates URLs that redirect to a short-lived service URL. By switching to `:rails_storage_proxy`, Active Storage will download files from your service directly by acting as a proxy. This setup makes it easy to cache using a CDN.