const container_organization = document.getElementById("organizations");

window.addEventListener("DOMContentLoaded", async () => {
  const res = await fetch(`/api/v1/organizations/follows`);
  if (res.status !== 200) return;
  const organizations = await res.json();
  
  for (const org of organizations) {
    container_organization.innerHTML = `
    <div class="card mb-3 border-1">
      <div class="text-bg-dark p-3 d-flex justify-content-center align-items-center">
        <h5 class="card-title">${org.name}</h5>
      </div>
      <div class="card-body d-flex justify-content-center align-items-center">
        <p class="card-text">${org.description}</p>
      </div>
    </div>
    `;
  }
});
