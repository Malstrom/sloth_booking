import {Controller} from "@hotwired/stimulus"
import * as bootstrap from "bootstrap";

export default class extends Controller {

  connect() {
    var data = {bookable_id: null, bookable_type: null, price: document.getElementById("price").value}
    document.getElementById("params_to_send").value = JSON.stringify(data);

    document.querySelectorAll('.toast').forEach((toastTarget) => {
      return new bootstrap.Toast(toastTarget).show();
    })
  }

  presetValue(){
    // this.element.innerHTML = "Set new";
  }


  // todo: open collapse and show additional information about event
  // set value to hidden input
  selectKind(){
    // document.getElementById("eventAdditionalInfo").innerHTML = this.element.value
    document.getElementById("params_to_send").value = this.element.value;
  }

  // triggered when fill in input price and trigger hidden input
  setPrice(){
    var data = {bookable_id: null, bookable_type: null, price: document.getElementById("price").value }
    document.getElementById("params_to_send").value = JSON.stringify(data);
  }

  // function for change price for table in certain hour
  handleTime() {
    let time = this.element.value
  }

  // update backend certain slot with new slot kind/value or kind/price
  handleClick() {
    var slot = JSON.parse(document.getElementById("params_to_send").value);
    const data = JSON.stringify({slot});

    fetch("../slots/" + this.element.id, {
      method: "PUT",
      dataType: "json",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept" : "application/json",
        "Content-Type": 'application/json; charset=UTF-8',
      },
      body: data
    }).then(response => response.json()).then(slot => {

      const tableClass = this.element.className.match(new RegExp(/\bcell-color-.+?\b/, 'g'))

      this.element.classList.remove(tableClass);
      this.element.classList.add(slot.color);
      this.element.innerHTML = slot.display_value
    })
  }
}