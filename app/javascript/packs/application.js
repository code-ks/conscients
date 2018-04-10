/* eslint no-console:0 */

import Rails from "rails-ujs";
import Turbolinks from "turbolinks";
import "../plugins/bootstrap";

Rails.start();
Turbolinks.start();

console.log("Hello World from Webpacker");
