import {Controller} from "@hotwired/stimulus"
import * as bootstrap from "bootstrap";

export default class extends Controller {

  connect() {
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
    let state = this.element.dataset.state
    let slot = document.getElementById("params_to_send").value

    if (state === 'booked'){
      this.editBooking()
    }
    else {
      slot === '' ? this.newEvent() : this.sendToBack(slot)
    }
  }

  newEvent(){
    new bootstrap.Modal(document.getElementById('eventModal')).show();
  }

  editBooking(){}

  sendToBack(slot){
    slot = JSON.parse(slot)
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
    }).then((response) => {
      if (response.ok) {
        return response.json();
      }
      throw new Error('Something went wrong');
    })
      .then((slot) => {
        const tableClass = this.element.className.match(new RegExp(/\bcell-color-.+?\b/, 'g'))

        this.element.classList.remove(tableClass);
        this.element.classList.add(slot.color);
        this.element.innerHTML = slot.display_value
      })
      .catch((error) => {
        alert("Время ячейки уже прошло")
        console.log(error)
      });
  }
}
