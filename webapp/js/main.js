const form = document.getElementById('contactForm');
form.addEventListener('submit', function(e) {
    e.preventDefault();

    fetch("${API_ENDPOINT}/users",
    {
        method: "POST",
        body: JSON.stringify({
            userID: 23,
            name: document.getElementById("name").value,
            email: document.getElementById("email").value, 
            career: document.getElementById("career").value,
            description: document.getElementById("description").value,
            skills: document.getElementById("skills").value,
            passions: document.getElementById("passions").value,
        })
    })
    .then(function(res){ window.location.href = "profile.html"; /*return res.json();*/ })
    //.then(function(data){ alert( JSON.stringify( data ) ) })
})