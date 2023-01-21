const eventsNode = document.getElementById("events");

const gotoEvent = (evt_id) => {
  window.location.assign(`/pages/event.html?evt_id=${evt_id}`);
};

window.addEventListener("DOMContentLoaded", async () => {
  const items = localStorage.getItem("events");
  let events = items && JSON.parse(items);

  if (!events || events.length === 0) {
    const res = await fetch(`/api/v1/events/`);
    if (res.status !== 200) return;
    events = await res.json();
    localStorage.setItem("events", JSON.stringify(events));
  }

  for (const event of events) {
    eventsNode.innerHTML += `
    <div class="card" style="width: 18rem;">
      <div class="card-body">
        <h5 class="card-title">${event.name}</h5>
        <h6 class="card-subtitle mb-2 text-muted">${event.date}</h6>
        <p class="card-text">${event.description}</p>
        <a href="#" class="card-link" onclick="gotoEvent('${event.evt_id}')">Ver evento</a>
        <a href="#" class="card-link" onclick="deleteEvent('${event.evt_id}')">Eliminar evento</a>
      </div>
    </div>
    `;
  }
});
