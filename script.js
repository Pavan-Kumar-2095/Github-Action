document.addEventListener("DOMContentLoaded", () => {

    console.log("CI/CD Demo Loaded");

    const badge = document.querySelector(".badge");

    const now = new Date();

    badge.innerHTML = `● Live Deployment • ${now.toLocaleDateString()}`;

});