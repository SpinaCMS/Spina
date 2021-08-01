# API Pagination

All API endpoints that list records are paginated. The API adds two attributes to the returned JSON body, `meta` and `links`. Both contain information about the paginated list. Here's an example of what gets added to the `/api/pages.json` response:

```
"meta": {
  "current_page": 1,
  "total": 75,
  "per_page": 25,
  "path": "/api/pages"
},
"links": {
  "first": "/api/pages?page=1",
  "prev": null,
  "next": "/api/pages?page=2",
  "last": "/api/pages?page=3"
}
```

You can use this information to fetch the rest of your pages using the API.