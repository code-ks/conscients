/* eslint no-console:0 */

import Rails from "rails-ujs";
import Turbolinks from "turbolinks";
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import "social-likes-next";
import "social-likes-next/lib/social-likes_flat.css";
import "../src/js/show_on_scroll";
import "../plugins/bootstrap";
import "../plugins/flatpickr";
import "../plugins/gmaps";
import "../plugins/quill";

Rails.start();
Turbolinks.start();

const application = Application.start();
const context = require.context("controllers", true, /.js$/);
application.load(definitionsFromContext(context));
