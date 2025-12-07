@echo off
echo ========================================
echo E-Voting System - Starting Server
echo ========================================
echo.

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Start the Django server
echo Starting Django development server...
echo.
echo Open your browser and go to:
echo   http://127.0.0.1:8000/
echo.
echo Admin Panel:
echo   http://127.0.0.1:8000/admin/
echo.
echo Login with:
echo   Email: admin@admin.com
echo   Password: admin
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

python manage.py runserver
