const tituloF = document.getElementById("titulo");
const fechaF = document.getElementById("fecha");
const precioF = document.getElementById("precio");
const descripcionF = document.getElementById("descripcion");

const submitForm = document.getElementById("submit-form");

submitForm.addEventListener("click", async (e) => {
  e.preventDefault();

  const titulo = tituloF.value;
  const fecha = fechaF.value;
  const precio = precioF.value;
  const descripcion = descripcionF.value;

  if (titulo === "" || fecha === "" || precio === "" || descripcion === "") {
    alert("Please fill all the fields");
    return;
  }

  const res = await fetch(`/api/v1/events`, {
    method: "POST",
    body: JSON.stringify({
      name: titulo,
      date: fecha,
      // TODO: Get browser location
      location: "Guayaquil",
      description: descripcion,
      price: precio,
      // TODO: Get real time.
      time: "00:00",
      // TODO: Get org id somehow.
      org_id: "1234",
    }),
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (res.status !== 200) {
    alert("There was an error creating the event");
    return;
  }

  const events = JSON.parse(localStorage.getItem("events")) || [];

  events.push(await res.json());

  localStorage.setItem("events", JSON.stringify(events));

  window.location.assign("/");
});
