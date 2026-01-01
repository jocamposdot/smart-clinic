// Script Playwright para capturar screenshots automaticamente
// Execute: npx playwright install chromium (primeira vez)
// Execute: node capturar-screenshots.js

const { chromium } = require('playwright');
const path = require('path');
const fs = require('fs');

const BASE_URL = 'http://localhost:8080/api';
const SCREENSHOTS_DIR = path.join(__dirname, 'screenshots');

// Criar diretório de screenshots se não existir
if (!fs.existsSync(SCREENSHOTS_DIR)) {
    fs.mkdirSync(SCREENSHOTS_DIR, { recursive: true });
}

async function capturarScreenshots() {
    console.log('🚀 Iniciando captura de screenshots...\n');
    
    const browser = await chromium.launch({ headless: false });
    const context = await browser.newContext({
        viewport: { width: 1280, height: 720 }
    });
    const page = await context.newPage();

    try {
        // Q13: Admin Portal Login
        console.log('📸 Capturando Q13: Admin Portal Login...');
        await page.goto(`file://${path.join(__dirname, 'frontend/admin/index.html')}`);
        await page.waitForTimeout(2000);
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q13-admin-login.png'), fullPage: true });
        console.log('✅ Q13 capturado!\n');

        // Q14: Doctor Portal Login
        console.log('📸 Capturando Q14: Doctor Portal Login...');
        await page.goto(`file://${path.join(__dirname, 'frontend/doctor/index.html')}`);
        await page.waitForTimeout(2000);
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q14-doctor-login.png'), fullPage: true });
        console.log('✅ Q14 capturado!\n');

        // Q15: Patient Portal Login
        console.log('📸 Capturando Q15: Patient Portal Login...');
        await page.goto(`file://${path.join(__dirname, 'frontend/patient/index.html')}`);
        await page.waitForTimeout(2000);
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q15-patient-login.png'), fullPage: true });
        console.log('✅ Q15 capturado!\n');

        // Q16: Admin Adding Doctor
        console.log('📸 Capturando Q16: Admin Adding Doctor...');
        await page.goto(`file://${path.join(__dirname, 'frontend/admin/index.html')}`);
        await page.waitForTimeout(2000);
        
        // Fazer login
        await page.fill('#email', 'admin@smartclinic.com');
        await page.fill('#password', 'senha123');
        await page.click('button[type="submit"]');
        
        // Aguardar dashboard aparecer (com retry)
        try {
            await page.waitForSelector('#dashboardContainer:not(.hidden)', { state: 'visible', timeout: 15000 });
        } catch (e) {
            console.log('⚠️ Dashboard não apareceu automaticamente, tentando aguardar mais...');
            await page.waitForTimeout(5000);
            // Tentar verificar se está visível agora
            const isVisible = await page.locator('#dashboardContainer').isVisible();
            if (!isVisible) {
                console.log('⚠️ Login pode ter falhado. Capturando tela atual mesmo assim...');
            }
        }
        
        await page.waitForTimeout(2000);
        
        // Tentar preencher formulário se visível
        try {
            await page.waitForSelector('#doctorName', { state: 'visible', timeout: 5000 });
            await page.fill('#doctorName', 'Dr. Maria Costa');
            await page.fill('#doctorEmail', 'maria.costa@smartclinic.com');
            await page.fill('#doctorPhone', '(11) 98765-4323');
            await page.fill('#doctorSpecialty', 'Pediatria');
            await page.fill('#doctorPassword', 'senha123');
            await page.fill('#availableTimes', '08:00,09:00,14:00,15:00');
        } catch (e) {
            console.log('⚠️ Formulário não encontrado, capturando tela atual...');
        }
        
        await page.waitForTimeout(1000);
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q16-admin-add-doctor.png'), fullPage: true });
        console.log('✅ Q16 capturado!\n');

        // Q17: Patient Searching Doctor
        console.log('📸 Capturando Q17: Patient Searching Doctor...');
        await page.goto(`file://${path.join(__dirname, 'frontend/patient/index.html')}`);
        await page.waitForTimeout(2000);
        
        // Fazer login
        await page.fill('#email', 'maria.santos@example.com');
        await page.fill('#password', 'senha123');
        await page.click('button[type="submit"]');
        
        // Aguardar dashboard aparecer
        try {
            await page.waitForSelector('#dashboardContainer:not(.hidden)', { state: 'visible', timeout: 15000 });
        } catch (e) {
            console.log('⚠️ Dashboard não apareceu, aguardando mais...');
            await page.waitForTimeout(5000);
        }
        
        await page.waitForTimeout(2000);
        
        // Buscar médico
        try {
            await page.waitForSelector('#searchInput', { state: 'visible', timeout: 5000 });
            await page.fill('#searchInput', 'João');
            await page.click('#searchBtn');
            await page.waitForTimeout(3000);
        } catch (e) {
            console.log('⚠️ Campo de busca não encontrado, capturando tela atual...');
        }
        
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q17-patient-search-doctor.png'), fullPage: true });
        console.log('✅ Q17 capturado!\n');

        // Q18: Doctor Viewing Appointments
        console.log('📸 Capturando Q18: Doctor Viewing Appointments...');
        await page.goto(`file://${path.join(__dirname, 'frontend/doctor/index.html')}`);
        await page.waitForTimeout(2000);
        
        // Fazer login
        await page.fill('#email', 'joao.silva@smartclinic.com');
        await page.fill('#password', 'senha123');
        await page.click('button[type="submit"]');
        
        // Aguardar dashboard aparecer
        try {
            await page.waitForSelector('#dashboardContainer:not(.hidden)', { state: 'visible', timeout: 15000 });
        } catch (e) {
            console.log('⚠️ Dashboard não apareceu, aguardando mais...');
            await page.waitForTimeout(5000);
        }
        
        await page.waitForTimeout(2000);
        
        await page.screenshot({ path: path.join(SCREENSHOTS_DIR, 'q18-doctor-appointments.png'), fullPage: true });
        console.log('✅ Q18 capturado!\n');

        console.log('========================================');
        console.log('✅ TODOS OS SCREENSHOTS CAPTURADOS!');
        console.log('========================================');
        console.log(`📁 Screenshots salvos em: ${SCREENSHOTS_DIR}`);
        console.log('\nArquivos gerados:');
        console.log('  - q13-admin-login.png');
        console.log('  - q14-doctor-login.png');
        console.log('  - q15-patient-login.png');
        console.log('  - q16-admin-add-doctor.png');
        console.log('  - q17-patient-search-doctor.png');
        console.log('  - q18-doctor-appointments.png');

    } catch (error) {
        console.error('❌ Erro ao capturar screenshots:', error);
    } finally {
        await browser.close();
    }
}

capturarScreenshots();

