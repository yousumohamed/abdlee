# E-Voting System - Automated Setup Script for Windows
# This script will set up the entire Django e-voting application

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "E-Voting System - Automated Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check if Python is installed
Write-Host "[1/6] Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python not found! Please install Python from https://www.python.org/downloads/" -ForegroundColor Red
    exit 1
}

# Step 2: Create Virtual Environment
Write-Host ""
Write-Host "[2/6] Creating virtual environment..." -ForegroundColor Yellow
if (Test-Path "venv") {
    Write-Host "✓ Virtual environment already exists" -ForegroundColor Green
} else {
    python -m venv venv
    if ($?) {
        Write-Host "✓ Virtual environment created successfully" -ForegroundColor Green
    } else {
        Write-Host "✗ Failed to create virtual environment" -ForegroundColor Red
        exit 1
    }
}

# Step 3: Activate Virtual Environment
Write-Host ""
Write-Host "[3/6] Activating virtual environment..." -ForegroundColor Yellow
& ".\venv\Scripts\Activate.ps1"
if ($?) {
    Write-Host "✓ Virtual environment activated" -ForegroundColor Green
} else {
    Write-Host "! Activation failed. You may need to run:" -ForegroundColor Yellow
    Write-Host "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Yellow
}

# Step 4: Install Requirements
Write-Host ""
Write-Host "[4/6] Installing required packages..." -ForegroundColor Yellow
pip install --upgrade pip
pip install -r requirements.txt
if ($?) {
    Write-Host "✓ All packages installed successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to install packages" -ForegroundColor Red
    exit 1
}

# Step 5: Run Migrations
Write-Host ""
Write-Host "[5/6] Setting up database..." -ForegroundColor Yellow
python manage.py makemigrations
python manage.py migrate
if ($?) {
    Write-Host "✓ Database setup complete" -ForegroundColor Green
} else {
    Write-Host "✗ Database setup failed" -ForegroundColor Red
    exit 1
}

# Step 6: Create Superuser (Optional)
Write-Host ""
Write-Host "[6/6] Admin user setup" -ForegroundColor Yellow
Write-Host "Would you like to create an admin user now? (Y/N)" -ForegroundColor Cyan
$response = Read-Host
if ($response -eq "Y" -or $response -eq "y") {
    python manage.py createsuperuser
} else {
    Write-Host "Skipping admin user creation. You can create one later with:" -ForegroundColor Yellow
    Write-Host "  python manage.py createsuperuser" -ForegroundColor Yellow
}

# Setup Complete
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "To start the server, run:" -ForegroundColor Cyan
Write-Host "  python manage.py runserver" -ForegroundColor White
Write-Host ""
Write-Host "Then open your browser and go to:" -ForegroundColor Cyan
Write-Host "  http://127.0.0.1:8000/" -ForegroundColor White
Write-Host ""
Write-Host "Admin panel:" -ForegroundColor Cyan
Write-Host "  http://127.0.0.1:8000/admin/" -ForegroundColor White
Write-Host ""
