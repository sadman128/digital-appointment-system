document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const role = document.getElementById('role').value;

    try {
        const response = await fetch('http://localhost:3000/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password, role })
        });

        const data = await response.json();

        if (response.ok) {
            // ✅ Store username in localStorage for use on other pages
            localStorage.setItem('username', username);
            localStorage.setItem('role', role);
            window.location.href = data.redirect;
        } else {
            document.getElementById('error').textContent = data.message;
        }
    } catch (error) {
        console.error('Login error:', error);
        document.getElementById('error').textContent = 'Login failed. Please try again.';
    }
});
