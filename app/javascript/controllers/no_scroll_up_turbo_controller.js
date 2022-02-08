import { Controller } from '@hotwired/stimulus'
import { Turbo } from '@hotwired/turbo-rails'

export default class extends Controller {
  connect() {
    console.log("yo")
    if (window.previousPageWasAPaneLaunchPage) {
      document.removeEventListener('turbo:before-render', disableTurboScroll)
      document.removeEventListener('turbo:render', pageRendered)
    }

    document.addEventListener('turbo:visit', fetchRequested)
    document.addEventListener('turbo:before-render', disableTurboScroll)
    document.addEventListener('turbo:render', pageRendered)
  }

  disconnect() {
    document.removeEventListener('turbo:visit', fetchRequested)
  }
}

function fetchRequested() {
  window.previousPageWasAPaneLaunchPage = true
  window.paneStartPageScrollY = window.scrollY
}

function disableTurboScroll() {
    if (!window.previousPageWasAPaneLaunchPage) Turbo.navigator.currentVisit.scrolled = true
}

function pageRendered() {
  if (window.previousPageWasAPaneLaunchPage) window.paneStartPageScrollY = null
  if (window.paneStartPageScrollY)
    window.scrollTo(0, window.paneStartPageScrollY)
}
