# Resources

Besides the regular list of pages you can also manage a different set of pages. This is called a `Spina::Resource`. This is useful if you want to manage a list of pages without having to write an entire plugin. Some good examples include:

- a simple blog
- landing pages for SEO
- a list of team members

Every resource appears as a new list item in the website navigation of Spina. You can create new pages that belong to a resource. These pages can be nested, but not manually ordered. Pages within resources can be ordered by created_at or by title. This allows resources to have huge lists of pages using infinite scrolling.

**Create a new Resource**

A resource is just a single record, created like this:

```
Spina::Resource.create(name: "blogposts", label: "Blogposts")
```

**Scopes**

After introducing resources in your Spina app you sometimes have to make a distinction between regular pages and other pages. You can do that using scopes: `Spina::Page.regular_pages` or `Spina::Page.resource_pages`.

Fetching all pages of a particular resource is done like this: `Spina::Resource.find_by(name: "blogposts").pages`.

**Available options**

Every resource can have the following attributes:

- name
- label
- view_template
- order_by
- parent_page_id

When defining a parent page, all pages within that resource will be scoped to that parent page. This means that all generated URL's will be prefixed with the parent page's URL. An example: you can create a regular page called `blog` and have a resource called `blogposts`. Your blog view template could then list all pages that are inside the blog resource. In Spina you would have a nice separate menu called "Blogposts" where you can easily manage a list of blogposts. 

**Updating resources and page slugs/paths**

After updating a resource and changing it's slug, a background job is created. This background job saves all pages inside that resource, triggering a callback that sets new materialized paths. Be sure to setup a background worker (using Sidekiq for instance) in your production environment to perform these tasks.