import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "link" ]

  confirm(event) {
    if (!confirm("Tem certeza?")) {
      event.preventDefault();
    }
  }
}

