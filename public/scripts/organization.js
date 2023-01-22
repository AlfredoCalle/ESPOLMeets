const organization = document.getElementById("organization");
const org_id = window.location.search.slice(8);

window.addEventListener("DOMContentLoaded", async () => {
  const res = await fetch(`/api/v1/organizations/${org_id}`);
  if (res.status !== 200) return;
  org = await res.json();

  organization.innerHTML = `
    <div class="card mb-3 border-0">
      <div class="text-bg-dark p-5 d-flex justify-content-center align-items-center">
        <h5 class="card-title">${org.name}</h5>
      </div>
      <div class="card-body d-flex justify-content-center align-items-center">
        <p class="card-text">${org.description}</p>
      </div>
    </div>
  `;
});
