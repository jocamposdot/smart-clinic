const API_BASE_URL = 'http://localhost:8090/api';

let authToken = localStorage.getItem('patientToken');

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
        const response = await fetch(`${API_BASE_URL}/auth/patient/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();
        if (response.ok && data.success) {
            authToken = data.data.token;
            localStorage.setItem('patientToken', authToken);
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

document.getElementById('searchBtn').addEventListener('click', searchDoctors);
document.getElementById('searchInput').addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        searchDoctors();
    }
});

async function searchDoctors() {
    const searchTerm = document.getElementById('searchInput').value.trim();
    const doctorsList = document.getElementById('doctorsList');

    if (!searchTerm) {
        doctorsList.innerHTML = '<p>Digite o nome do médico para buscar.</p>';
        return;
    }

    doctorsList.innerHTML = '<p>Buscando médicos...</p>';

    try {
        const response = await fetch(`${API_BASE_URL}/doctors/search?name=${encodeURIComponent(searchTerm)}`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        const data = await response.json();
        if (response.ok && data.success) {
            const doctors = data.data || [];
            if (doctors.length === 0) {
                doctorsList.innerHTML = '<p>Nenhum médico encontrado com esse nome.</p>';
            } else {
                doctorsList.innerHTML = doctors.map(doctor => {
                    return `
                        <div class="doctor-card">
                            <h3>Dr(a). ${doctor.name}</h3>
                            <p><strong>Especialidade:</strong> ${doctor.specialty}</p>
                            <p><strong>Email:</strong> ${doctor.email}</p>
                            ${doctor.phone ? `<p><strong>Telefone:</strong> ${doctor.phone}</p>` : ''}
                        </div>
                    `;
                }).join('');
            }
        } else {
            doctorsList.innerHTML = '<p>Erro ao buscar médicos.</p>';
        }
    } catch (error) {
        doctorsList.innerHTML = '<p>Erro de conexão ao buscar médicos.</p>';
    }
}

document.getElementById('logoutBtn').addEventListener('click', () => {
    localStorage.removeItem('patientToken');
    authToken = null;
    showLogin();
});

