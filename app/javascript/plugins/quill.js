import Quill from "quill";
import "quill/dist/quill.snow.css";

const quillFr = new Quill("#body-fr-editor", {
  theme: "snow"
});

const quillEn = new Quill("#body-en-editor", {
  theme: "snow"
});

const form = document.getElementById("blog-post-form");
form.onsubmit = () => {
  const contentFr = document.getElementById("body-fr-content");
  contentFr.value = quillFr.root.innerHTML;

  const contentEn = document.getElementById("body-en-content");
  contentEn.value = quillEn.root.innerHTML;
};
