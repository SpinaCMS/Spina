# Upgrading Spina CMS
This file lists all changes that you need to make in your Spina app to ensure a smooth upgrade.

## [1.1.3] to Unreleased

### Structures in views
When calling `content` on a `Structure` page part Spina will now return the underlying items instead of the structure itself. That means you need to change all views using a structure. 

Before:
```ruby
content(:a_structure).structure_items.sorted_by_structure.each do |item|
  # ...
end
```

After:
```ruby
content(:a_structure).each do |item|
  # ...
end
```