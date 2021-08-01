# Navigations API

## List navigations

Endpoint: 
```
/api/navigations.json
```

Result:
```
{
  "data": [
    {
      "id": "2",
      "type": "navigation",
      "attributes": {
        "name": "main",
        "label": "Main navigation"
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "total": 1,
    "per_page": 25,
    "path": "/api/navigations"
  },
  "links": {
    "first": "/api/navigations?page=1",
    "prev": null,
    "next": null,
    "last": "/api/navigations?page=1"
  }
}
```

## Show page

Endpoint:
```
/api/navigations/{id}.json
```

Result:
```
{
  "data": {
    "id": "2",
    "type": "navigation",
    "attributes": {
      "name": "main",
      "label": "Main navigation",
      "tree": [
        {
          "depth": 0,
          "page": {
            "id": 1,
            "menu_title": "Homepage",
            "materialized_path": "/"
          },
          "children": []
        },
        {
          "depth": 0,
          "page": {
            "id": 32,
            "menu_title": "Demo page",
            "materialized_path": "/demo-page"
          },
          "children": [
            {
              "depth": 1,
              "page": {
                "id": 21,
                "menu_title": "Sub page",
                "materialized_path": "/guides/sub-page"
              },
              "children": []
            }
          ]
        }
      ]
    }
  }
}
```