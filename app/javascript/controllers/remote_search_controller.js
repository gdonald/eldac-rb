import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['results']

  static values = {
    term: String
  }

  connect() {
    let that = this

    fetch(`/remote_search/?q=${this.termValue}`).then(
      function (response) {
        return response.text()
      }).then(function (html) {
        that.resultsTarget.parentElement.innerHTML = html
        return true
      }).catch(function (error) {
        console.warn('An error occured:', error)
        return false
      })
  }
}
