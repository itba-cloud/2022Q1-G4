fetch("${API_ENDPOINT}/users/23")
.then(async response => {
    const data = await response.json();

    // check for error response
    if (!response.ok) {
        const error = (data && data.message) || response.status;
        return Promise.reject(error);
    }

    var template_left = document.getElementById('template_left').innerHTML;
    var template_right = document.getElementById('template_right').innerHTML;

    var params = { name: data.Item.name, email: data.Item.email, career: data.Item.career, description: data.Item.description, skills: data.Item.skills, passions: data.Item.passions }

    var rendered_left = Mustache.render(template_left, params);
    document.getElementById('target_left').innerHTML = rendered_left;

    var rendered_right = Mustache.render(template_right, params);
    document.getElementById('target_right').innerHTML = rendered_right;

    element.innerHTML = data?.total;
})
