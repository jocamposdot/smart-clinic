const API_BASE_URL = 'http://localhost:8090/api';

let authToken = localStorage.getItem('adminToken');

if (authToken) {
    showDashboard();
} else {
    showLogin();
}

function showLogin() {
    document.getElementById('loginContainer').classList.remove('hidden');
    document.getElementById('dashboardContainer').classList.add('hidden');
}

function showDashboard() {
    document.getElementById('loginContainer').classList.add('hidden');
    document.getElementById('dashboardContainer').classList.remove('hidden');
}

document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('errorMessage');

    try {
        const response = await fetch(`${API_BASE_URL}/auth/admin/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();
        if (response.ok && data.success) {
            authToken = data.data.token;
            localStorage.setItem('adminToken', authToken);
            showDashboard();
        } else {
            errorDiv.textContent = data.message || 'Erro ao fazer login';
            errorDiv.classList.add('show');
        }
    } catch (error) {
        errorDiv.textContent = 'Erro de conexão. Certifique-se de que o backend está rodando.';
        errorDiv.classList.add('show');
    }
});

document.getElementById('addDoctorForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const successDiv = document.getElementById('successMessage');
    const errorDiv = document.getElementById('addDoctorError');
    
    const times = document.getElementById('availableTimes').value
        .split(',')
        .map(t => t.trim())
        .filter(t => t);

    const doctorData = {
        name: document.getElementById('doctorName').value,
        email: document.getElementById('doctorEmail').value,
        phone: document.getElementById('doctorPhone').value || null,
        specialty: document.getElementById('doctorSpecialty').value,
        password: document.getElementById('doctorPassword').value,
        availableTimes: times
    };

    try {
        const response = await fetch(`${API_BASE_URL}/admin/doctors`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify(doctorData)
        });

        const data = await response.json();
        if (response.ok && data.success) {
            successDiv.textContent = 'Médico adicionado com sucesso!';
            successDiv.classList.add('show');
            errorDiv.classList.remove('show');
            document.getElementById('addDoctorForm').reset();
            setTimeout(() => successDiv.classList.remove('show'), 3000);
        } else {
            errorDiv.textContent = data.message || 'Erro ao adicionar médico';
            errorDiv.classList.add('show');
            successDiv.classList.remove('show');
        }
    } catch (error) {
        errorDiv.textContent = 'Erro de conexão';
        errorDiv.classList.add('show');
        successDiv.classList.remove('show');
    }
});

document.getElementById('logoutBtn').addEventListener('click', () => {
    localStorage.removeItem('adminToken');
    authToken = null;
    showLogin();
});

