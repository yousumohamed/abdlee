import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'e_voting.settings')
django.setup()

from account.models import CustomUser

# Set password for admin user
try:
    admin = CustomUser.objects.get(email='admin@admin.com')
    admin.set_password('admin')
    admin.save()
    print("Admin password set successfully!")
    print("  Email: admin@admin.com")
    print("  Password: admin")
except CustomUser.DoesNotExist:
    print("Admin user not found")
