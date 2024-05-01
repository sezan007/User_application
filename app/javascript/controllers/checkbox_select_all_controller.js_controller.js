import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox-select-all-controller.js"
export default class extends Controller {
  static targets = ["parent", "child"]
  connect() {
    this.parentTarget.hidden = true
    //this.childTarget.hidden = true
    //this.childTarget.map(x => x.hidden = true)
  }
}
