import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static values = {
    id: String,
    read: Boolean,
    url: String
  }

  connect() {
    this.markAsRead()
  }

  markAsRead() {
    if (this.urlValue && !this.readValue) {
      patch(this.urlValue)
    }
  }
}
