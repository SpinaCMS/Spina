# Resources API

## List resources

Endpoint: 
```
/api/resources.json
```

Result:
```
{
  "data": [
    {
      "id": "4",
      "type": "resource",
      "attributes": {
        "name": "guide",
        "label": "Guides",
        "view_template": "",
        "order_by": "",
        "slug": "guides"
      },
      "relationships": {
        "pages": {
          "meta": {
            "count": 5
          },
          "links": {
            "self": "/api/resources/4",
            "related": "/api/resources/4/pages"
          }
        }
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "total": 1,
    "per_page": 25,
    "path": "/api/resources"
  },
  "links": {
    "first": "/api/resources?page=1",
    "prev": null,
    "next": null,
    "last": "/api/resources?page=1"
  }
}
```

## Show resource

Endpoint:
```
/api/resources/{id}.json
```

Result:
```
{
  "data": {
    "id": "4",
    "type": "resource",
    "attributes": {
      "name": "guide",
      "label": "Guides",
      "view_template": "",
      "order_by": "",
      "slug": "guides"
    },
    "relationships": {
      "pages": {
        "meta": {
          "count": 5
        },
        "links": {
          "self": "/api/resources/4",
          "related": "/api/resources/4/pages"
        }
      }
    }
  }
}
```

## List pages in resource

Endpoint:
```
/api/resources/{id}/pages.json
```

Result:
```
{
  "data": [
    {
      "id": "11",
      "type": "page",
      ...
    }
    ...
  ],
  "meta": {
    "current_page": 1,
    "total": 5,
    "per_page": 25,
    "path": "/api/resources/4/pages"
  },
  "links": {
    "first": "/api/resources/4/pages?page=1",
    "prev": null,
    "next": null,
    "last": "/api/resources/4/pages?page=1"
  }
}
```