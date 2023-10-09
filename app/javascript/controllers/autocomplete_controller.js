import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'q', 'results']

  static values = {
    selected: Number,
    resultsCount: Number
  }

  connect() {
    this.selectedValue = -1
  }

  search(event) {
    let keyCode = event.keyCode

    this.updateSelected(keyCode)

    // escape
    if (keyCode === 27) {
      this.hideResults()
      return
    }

    // enter
    if (keyCode === 13) {
      if (this.selectedValue > -1) {
        let ul = this.resultsTarget.children[0]
        let li = ul.children[this.selectedValue]
        this.qTarget.value = li.innerText
      }

      this.formTarget.submit()
      return
    }

    let term = event.target.value

    let that = this
    fetch(`/search/autocomplete?q=${term}`).then(
      function (response) {
        return response.json()
      }).then(function (results) {
        that.resultsCountValue = results.length

        if (results.length === 0) {
          that.hideResults()
        } else {
          that.resultsTarget.innerHTML = that.drawResults(results)
          that.resultsTarget.style.display = 'block'
          that.rebindResults()
        }
        return true
      }).catch(function (error) {
        console.warn('An error occured:', error)
        return false
      })
  }

  updateSelected(keyCode) {
    if (keyCode === 40) { this.selectedValue += 1 }
    if (keyCode === 38) { this.selectedValue -= 1 }
    if (this.selectedValue < -1) { this.selectedValue = -1 }
    if (this.selectedValue > this.resultsCountValue - 1) { this.selectedValue = this.resultsCountValue - 1 }
  }

  drawResults(results) {
    let items = this.resultsToItems(results)
    return `<ul>${items}</ul>`
  }
  
  resultsToItems(results) {
    let that = this
    let items = results.map(function (item, index) {
      let selected = index === that.selectedValue ? ' selected' : ''
      return `<li class="result${selected}">${item}</li>`
    })
    return items.join('')
  }
  
  rebindResults() {
    var elements = document.getElementsByClassName('result')
  
    let that = this
    Array.from(elements).forEach(function (element) {
      element.addEventListener('click', function (event) {
        that.qTarget.value = event.target.innerText
        that.resultsTarget.innerHTML = ''
        that.formTarget.submit()
      })
    })
  }

  hideResults() {
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.style.display = 'none'
  }
}
