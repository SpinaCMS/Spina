# Images API

🚧 _The current images API returns three URLs with different image variants. This will be changed in the future to allow on the fly image transformations._

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
      "original_url": "http://spina.puma/rails/active_storage/blobs/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7298f153701e4c4be328b4ead0f0fec789c690b8/image.png",
      "thumbnail_url": "http://spina.puma/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7298f153701e4c4be328b4ead0f0fec789c690b8/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2RwQXBBQmFRS1FBUT09IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--61cb87d577de18e7e5fe1fe071051e28b86c3124/image.png",
      "embedded_image_size_url": "http://spina.puma/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7298f153701e4c4be328b4ead0f0fec789c690b8/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RkhKbGMybDZaVjkwYjE5c2FXMXBkRnNIYVFMUUIya0MwQWM9IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--c6a4091cd0d56cab0fbbd2e72b9959294b0b4cdc/image.png"
    }
  }
}
```