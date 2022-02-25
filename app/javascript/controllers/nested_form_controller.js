import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["insertElement", "templates", "association"]

  addAssociation(event) {
    event.preventDefault()
    var replace = `${this.associationTarget.value}_new_association`
    var re = new RegExp(replace, "g")
    let template = this.templatesTargets.find(template => template.id === this.associationTarget.value)
    let content = template.innerHTML.replace(re, new Date().getTime())
    this.insertElementTarget.insertAdjacentHTML("beforeend", content)
    // this.dispatch("addAssociation", { detail: { event: event } })
  }

  removeAssociation(event) {
    event.preventDefault()

    let wrapper = event.target.closest(".nested_fields")
    if (wrapper.dataset.newRecord == "true") {
      wrapper.remove()
    }
    else {
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = "none"
    }
  }
}
