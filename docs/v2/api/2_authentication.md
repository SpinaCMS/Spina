# API Authentication

The API requires authentication. If no API key is set in the initializer, Spina will return a 404 response.

The API uses HTTP Token authentication. Simply add the following header to all API calls to authenticate:

```
'Authorization': 'Token [your_api_key]'
```

Here's an example using `curl`:

```
curl -H "Authorization: Token dummy_api_key" http://localhost:3000/api/pages.json
```