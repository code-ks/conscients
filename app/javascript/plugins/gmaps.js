import GMaps from "gmaps/gmaps.js";

const mapElement = document.getElementById("map");
if (mapElement) {
  const map = new GMaps({
    el: "#map",
    lat: 0,
    lng: 0,
    minZoom: 2,
    maxZoom: 15
  });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(4);
  } else {
    map.fitLatLngBounds(markers);
  }
}
