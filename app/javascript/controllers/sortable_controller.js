import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    this.renumberPositions()
  }

  listen({ }) {
    this.renumberPositions()
  }

  renumberPositions() {
    var counter = 1
    this.element.querySelectorAll(".card").forEach(element => {
      element.querySelector("input[name*='[position]']").value = counter
      counter++
    })
  }
}