# Custom parts

All page content is stored in a single JSONB-column in the database. Spina uses the `attr_json` gem to work with these nested json objects. All default parts are `AttrJson::Model` objects. Follow the steps below to create your own custom part.

## Step 1. Create a part
Let's imagine our app contains a movie database. We'd like to add a part to select one of the movies in our collection. First we need to create the object that can be stored as page content.

```ruby
# app/models/spina/parts/movie.rb
module Spina
  module Parts
    class Movie < Base
      attr_json :movie_id, :integer

      def content
        Movie.find(movie_id)
      end

    end
  end
end
```

*In this simplified example we make the content method do a query and return a Movie record. Beware of N+1 queries if you go this route. Generally, the more you store directly in JSON, the better your performance.*

## Step 2. Create a view for page editing

```haml
-# app/views/spina/admin/parts/movies/_form.html.haml
.page-form-label= f.object.title
.page-form-control
  .select-dropdown= f.select :movie_id, Movie.all.pluck(:name, :id)
```

## Step 3. Register your new part

In an initializer, register your newly created part so you can use it in your theme:

`Spina::Part.register(Spina::Parts::Movie)`

## Step 4. Go wild

Of course, this is a very simple example. You can store a lot this way. You can take a look at the existing parts in Spina for inspiration. If you want to learn more, you can also [take a look at the attr_json readme](https://github.com/jrochkind/attr_json). 