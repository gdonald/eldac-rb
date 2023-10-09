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

  debounce = (func, timeout = 300) => {
    let id

    return (...args) => {
      clearTimeout(id)
      id = setTimeout(() => { func.apply(this, args) }, timeout)
    }
  }

  search = this.debounce((event) => this.doSearch(event))

  doSearch(event) {
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
    if (term.length < 2) { return }

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
    return `<ul>${this.resultsToItems(results)}</ul>`
  }
  
  resultsToItems(results) {
    let that = this

    return results.map(function (item, index) {
      let selected = index === that.selectedValue ? ' selected' : ''
      let highlightedItem = that.highlightItem(item);

      return `<li class="result${selected}" data-value="${item}">${highlightedItem}</li>`
    }).join('')
  }

  highlightItem(item) {
    let term = this.qTarget.value
    let remainder = item.replace(new RegExp(term, 'i'), '')
    let value = `${term}<strong data-value="${item}">${remainder}</strong>`

    return value
  }
  
  rebindResults() {
    var elements = document.getElementsByClassName('result')
  
    let that = this
    Array.from(elements).forEach(function (element) {
      element.addEventListener('click', function (event) {
        that.qTarget.value = event.target.dataset.value
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
