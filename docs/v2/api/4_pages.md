# Pages API

## List pages

Endpoint: 
```
/api/pages.json
```

Result:
```
{
  "data": [
    {
      "id": "1",
      "type": "page",
      "attributes": {
        "title": "Homepage",
        "seo_title": "Homepage",
        "menu_title": "Homepage",
        "materialized_path": "/",
        "name": "homepage",
        "description": null,
        "view_template": "homepage",
        "content": [
            {
                "headline": "Headline"
            }
        ]
      },
      "relationships": {
        "resource": {"data": null}
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "total": 1,
    "per_page": 25,
    "path": "/api/pages"
  },
  "links": {
    "first": "/api/pages?page=1",
    "prev": null,
    "next": null,
    "last": "/api/pages?page=1"
  }
}
```

## Show page

Endpoint:
```
/api/pages/{id}.json
```

Result:
```
{
  "data": {
    "id": "1",
    "type": "page",
    "attributes": {
      "title": "Homepage",
      "seo_title": "Homepage",
      "menu_title": "Homepage",
      "materialized_path": "/",
      "name": "homepage",
      "description": null,
      "view_template": "homepage",
      "content": [
          {
              "headline": "Headline"
          }
      ]
    },
    "relationships": {
      "resource": {"data": null}
    }
  }
}
```