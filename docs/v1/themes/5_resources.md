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
