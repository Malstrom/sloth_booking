import {Controller} from "@hotwired/stimulus"
import * as bootstrap from "bootstrap";

export default class extends Controller {

  connect() {
    document.querySelectorAll('.toastAlert').forEach((toastTarget) => {
      return new bootstrap.Toast(toastTarget).show();
    })

    // new bootstrap.Toast(document.getElementById('setInCalendar')).hide();
  }

  flushParamToSend(){
    document.getElementById("params_to_send").value = null;
    document.getElementById("overlay").classList.remove("background-overlay");
  }

  // todo: open collapse and show additional information about event
  // set value to hidden input
  selectKind(){
    // document.getElementById("eventAdditionalInfo").innerHTML = this.element.value
    document.getElementById("params_to_send").value = this.element.value;
    document.getElementById('toastBody').innerHTML = this.element.value;

    new bootstrap.Toast(document.getElementById('setInCalendar')).show();
    document.getElementById("overlay").classList.add("background-overlay");
  }

  // triggered when fill in input price and trigger hidden input
  setPrice(){
    var data = {bookable_id: null, bookable_type: null, price: document.getElementById("price").value }
    document.getElementById("params_to_send").value = JSON.stringify(data);
    document.getElementById('toastBody').innerHTML = "Updating price to: " + data.price;

    new bootstrap.Toast(document.getElementById('setInCalendar')).show();
    document.getElementById("overlay").classList.add("background-overlay");
  }

  // function for change price for table in certain hour
  handleTime() {
    let time = this.element.value
  }

  // update backend certain slot with new slot kind/value or kind/price
  handleClick() {
    let state = this.element.dataset.state
    let id = this.element.dataset.bookableid
    let type = this.element.dataset.bookabletype.toLowerCase()
    let bookable_id = type + "_" + id

    let slot = document.getElementById("params_to_send").value

    if (state === 'booked'){
      if (slot === ''){
        this.editBooking(bookable_id)
      }else {
        let json_slot = JSON.parse(slot)
        console.log(json_slot)
        console.log(id,type)
        if (json_slot.bookable_type.toLowerCase() === type && json_slot.bookable_id == id ){this.sendToBack(slot)}
      }
    }
    else {
      slot === '' ? this.newEvent() : this.sendToBack(slot)
    }
  }

  newEvent(){
    new bootstrap.Modal(document.getElementById('eventModal')).show();
  }

  editBooking(bookable_id){
    new bootstrap.Modal(document.getElementById(bookable_id)).show();
  }

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
        this.element.innerHTML = slot.display_value;

        (slot.bookable_id != null) ? this.element.dataset.state = 'booked' : this.element.dataset.state = '';


        this.element.dataset.bookableid = slot.bookable_id;
        this.element.dataset.bookabletype = slot.bookable_type;

      })
      .catch((error) => {
        alert("Время ячейки уже прошло")
        console.log(error)
      });
  }
}
