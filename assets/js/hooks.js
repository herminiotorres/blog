import "./highlighter";

let Hooks = {};

Hooks.Highlight = {
  mounted() {
    window.highlightAll(this.el)
  }
}

export default Hooks;
