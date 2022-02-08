// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import "@fortawesome/fontawesome-free/css/all";
import "../stylesheets/application";
import "../stylesheets/stripe_connect";
import { Application } from "stimulus"
import "../controllers"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import '@hotwired/turbo-rails'
require("flatpickr/dist/flatpickr.css")

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
// https://fontawesome.com/v5.15/how-to-use/on-the-web/using-with/turbolinks
// FontAwesome.config.mutateApproach = 'sync'

Rails.start()
ActiveStorage.start()

