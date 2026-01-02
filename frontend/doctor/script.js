const API_BASE_URL = 'http://localhost:8090/api';

let authToken = localStorage.getItem('doctorToken');
let doctorId = localStorage.getItem('doctorId');

if (authToken && doctorId) {
    showDashboard();
    loadAppointments();
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
        const response = await fetch(`${API_BASE_URL}/auth/doctor/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();
        if (response.ok && data.success) {
            authToken = data.data.token;
            doctorId = data.data.userId;
            localStorage.setItem('doctorToken', authToken);
            localStorage.setItem('doctorId', doctorId);
            showDashboard();
            loadAppointments();
        } else {
            errorDiv.textContent = data.message || 'Erro ao fazer login';
            errorDiv.classList.add('show');
        }
    } catch (error) {
        errorDiv.textContent = 'Erro de conexão. Certifique-se de que o backend está rodando.';
        errorDiv.classList.add('show');
    }
});

async function loadAppointments() {
    const appointmentsList = document.getElementById('appointmentsList');
    const today = new Date().toISOString().split('T')[0];

    try {
        const response = await fetch(`${API_BASE_URL}/appointments/doctor?date=${today}`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        const data = await response.json();
        if (response.ok && data.success) {
            const appointments = data.data || [];
            if (appointments.length === 0) {
                appointmentsList.innerHTML = '<p>Nenhuma consulta agendada para hoje.</p>';
            } else {
                appointmentsList.innerHTML = appointments.map(apt => {
                    const date = new Date(apt.appointmentTime);
                    return `
                        <div class="appointment-card">
                            <h3>Consulta #${apt.id}</h3>
                            <p><strong>Paciente:</strong> ${apt.patient.name}</p>
                            <p><strong>Data/Hora:</strong> ${date.toLocaleString('pt-BR')}</p>
                            <p><strong>Status:</strong> ${apt.status}</p>
                        </div>
                    `;
                }).join('');
            }
        } else {
            appointmentsList.innerHTML = '<p>Erro ao carregar consultas.</p>';
        }
    } catch (error) {
        appointmentsList.innerHTML = '<p>Erro de conexão ao carregar consultas.</p>';
    }
}

document.getElementById('logoutBtn').addEventListener('click', () => {
    localStorage.removeItem('doctorToken');
    localStorage.removeItem('doctorId');
    authToken = null;
    doctorId = null;
    showLogin();
});

