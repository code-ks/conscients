import Quill from "quill";
import "quill/dist/quill.snow.css";

const toolbarOptions = [
  ["bold", "italic", "underline", "strike"], // toggled buttons
  [{ header: 1 }, { header: 2 }, { header: [3, 4, 5, 6, false] }],
  [{ size: ["small", false, "large", "huge"] }], // custom button values
  [{ align: [] }],
  [{ list: "ordered" }, { list: "bullet" }],
  ["blockquote"],
  [{ indent: "-1" }, { indent: "+1" }],
  ["image", "link"],

  [{ color: [] }, { background: [] }], // dropdown with defaults from theme

  ["clean"] // remove formatting button
];

const quillOptions = {
  theme: "snow",
  modules: {
    toolbar: toolbarOptions
  }
};

$(document).on("turbolinks:load", () => {
  const bodyFrEditor = document.getElementById("content-fr-editor");

  if (bodyFrEditor) {
    const quillFr = new Quill("#content-fr-editor", quillOptions);
    const contentFr = document.getElementById("content-fr");
    const quillEn = new Quill("#content-en-editor", quillOptions);
    const contentEn = document.getElementById("content-en");
    quillFr.root.innerHTML = contentFr.value;
    quillEn.root.innerHTML = contentEn.value;

    const form = document.getElementById("blog-post-form");
    form.onsubmit = () => {
      contentFr.value = quillFr.root.innerHTML;
      contentEn.value = quillEn.root.innerHTML;
    };
  }
});
