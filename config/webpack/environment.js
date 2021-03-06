const { environment } = require("@rails/webpacker");

const webpack = require("webpack");
const erb = require("./loaders/erb");

environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"]
  })
);

environment.loaders.append("erb", erb);
module.exports = environment;
