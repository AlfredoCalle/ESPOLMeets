const deleteEvent = async (evt_id) => {
  const res = await fetch(`/api/v1/events/${evt_id}`, {
    method: "DELETE",
  });

  if (res.status !== 204) {
    alert("Failed to delete event");
    return;
  }

  const items = localStorage.getItem("events");

  if (items === null) {
    alert("Failed to delete event");
    return;
  }

  const events = JSON.parse(items) || [];
  const newEvents = events.filter((evt) => evt.evt_id !== evt_id);

  localStorage.setItem("events", JSON.stringify(newEvents));

  window.location.assign("/");
};
