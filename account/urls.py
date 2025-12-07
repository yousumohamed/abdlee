from django.urls import path
from . import views


urlpatterns = [
    path('', views.account_login, name="account_login"),
    path('register/', views.account_register, name="account_register"),
    path('pending/', views.pending_verification, name="pending_verification"),
    path('logout/', views.account_logout, name="account_logout"),
]
