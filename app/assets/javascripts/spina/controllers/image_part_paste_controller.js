import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // console.log('Image Part Paste controller connected!')
  }

  async paste() {
    console.log("Detected paste image action...")
    let clipboardItems
    try {
      clipboardItems = await navigator.clipboard.read()
    } catch (error) {
      console.error("Clipboard access denied:", error)
      return
    }

    for (const item of clipboardItems) {
      const imageType = item.types.find(type => type.startsWith("image/"))
      if (!imageType) continue

      const blob = await item.getType(imageType)
      const extension = imageType.split("/")[1] || "png"
      const file = new File([blob], `pasted-image.${extension}`, { type: imageType })

      await this.upload(file)
      return
    }
  }

  async upload(file) {
    console.log("Auto-uploaded pasted image...")
    const formData = new FormData()
    formData.append("image[files][]", file)
    formData.append("origin", "image-part")

    const token = document.querySelector('meta[name="csrf-token"]')?.content
    let response
    try {
      response = await fetch(this.uploadUrl, {
        method: "POST",
        headers: { "X-CSRF-Token": token, "Accept": "application/json" },
        body: formData
      })
    } catch (error) {
      console.error("Upload failed:", error)
      return
    }

    if (!response.ok) return

    const data = await response.json()
    this.element.dispatchEvent(new CustomEvent("media-picker:done", { detail: data, bubbles: true }))
  }

  get uploadUrl() {
    return this.element.dataset.imagePartPasteUploadUrl
  }
}
