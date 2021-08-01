# Images API

🚧 _The current images API returns a URL with an image variant that uses `resize_to_fill: [2000, 2000]`. This will be changed in the future to allow on the fly image transformations._

## Get image

Endpoint:
```
/api/images/{id}.json
```

Result:
```
{
  "data": {
    "id": "1",
    "type": "image",
    "attributes": {
      "id": 1,
      "url": "http://localhost:3000/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--fe5d0224236708489719038c1d259d1a19f854f8/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2RwQXRBSGFRTFFCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--73098ce3e6393809b81df37ce01366fdb579940c/image.png"
    }
  }
}
```