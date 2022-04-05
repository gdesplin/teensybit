import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = { selector: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(_event) {
    this.renumberPositions()
  }

  listen({ }) {
    this.renumberPositions()
  }

  renumberPositions() {
    var counter = 1
    this.element.querySelectorAll(this.selectorValue).forEach(element => {
      element.querySelector("input[name*='[position]']").value = counter
      counter++
    })
  }
}