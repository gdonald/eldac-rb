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
        // console.log('response', response.text());
        return response.text()
      }).then(function (results) {
        that.resultsTarget.innerHTML = results
        return true
      }).catch(function (error) {
        console.warn('An error occured:', error)
        return false
      })
  }
}
