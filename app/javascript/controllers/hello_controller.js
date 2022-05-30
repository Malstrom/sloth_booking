import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    var data = {kind: "default", price: document.getElementById("price").value}
    document.getElementById("params_to_send").value = JSON.stringify(data);
  }

  // todo: open collapse and show additional information about event
  // set value to hidden input
  selectKind(){
    document.getElementById("eventAdditionalInfo").innerHTML = this.element.value
    document.getElementById("params_to_send").value = this.element.value;
  }

  // triggered when fill in input price and trigger hidden input
  setPrice(){
    var data = {kind: "default", price: this.element.value}
    document.getElementById("params_to_send").value = JSON.stringify(data);
  }

  // function for change price for table in certain hour
  handleTime() {
    let time = this.element.value
  }

  // update backend certain timecell with new timecell kind/value or kind/price
  handleClick() {
    var timecell = JSON.parse(document.getElementById("params_to_send").value);
    const data = JSON.stringify({timecell});

    fetch("timecells/" + this.element.id, {
      method: "PUT",
      dataType: "json",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept" : "application/json",
        "Content-Type": 'application/json; charset=UTF-8',
      },
      body: data
    }).then(response => response.json()).then(timecell => {

      const tableClass = this.element.className.match(new RegExp(/\btable-.+?\b/, 'g'))
      this.element.classList.remove(tableClass);
      this.element.classList.add("table-" + timecell.color);

      this.element.querySelector('turbo-frame').innerHTML = timecell.display_value
    })
  }
}