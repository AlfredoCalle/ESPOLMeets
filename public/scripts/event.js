const event = document.getElementById("event");
const evt_id = window.location.search.slice(8);

window.addEventListener("DOMContentLoaded", async () => {
  const items = localStorage.getItem("events");

  if (!items) {
    window.location.assign("/");
    return;
  }

  const events = JSON.parse(items);
  const theEvent = events.filter((evt) => evt.evt_id === evt_id)[0];

  event.innerHTML = `
  <div class="card">
    <div class="card-header">
      ${theEvent.location}, ${theEvent.date}
    </div>
    <div class="card-body">
      <h5 class="card-title">${theEvent.name}</h5>
      <p class="card-text px-2">
       <span class="row">Description: ${theEvent.description}</span>
       <span class="row">${
         theEvent.price ? "Price: $" + theEvent.price : ""
       }</span>
      </p>
      <p>
      <a href="/pages/organization.html?org_id=${
        theEvent.org_id
      }" class="btn btn-primary">Organizer</a>
      <a href="#" class="btn btn-danger" onclick="deleteEvent('${evt_id}')">Delete</a>
    </div>
  </div>
  `;
});
