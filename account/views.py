from django.shortcuts import render, redirect, reverse
from .email_backend import EmailBackend
from django.contrib import messages
from .forms import CustomUserForm
from voting.forms import VoterForm
from django.contrib.auth import login, logout
# Create your views here.


def account_login(request):
    if request.user.is_authenticated:
        if request.user.user_type == '1':
            return redirect(reverse("adminDashboard"))
        else:
            return redirect(reverse("voterDashboard"))

    context = {}
    if request.method == 'POST':
        user = EmailBackend.authenticate(request, username=request.POST.get(
            'email'), password=request.POST.get('password'))
        if user != None:
            login(request, user)
            if user.user_type == '1':
                return redirect(reverse("adminDashboard"))
            else:
                return redirect(reverse("voterDashboard"))
        else:
            messages.error(request, "Invalid details")
            return redirect("/")

    return render(request, "voting/login.html", context)


def account_register(request):
    userForm = CustomUserForm(request.POST or None)
    voterForm = VoterForm(request.POST or None)
    context = {
        'form1': userForm,
        'form2': voterForm
    }
    if request.method == 'POST':
        if userForm.is_valid() and voterForm.is_valid():
            user = userForm.save(commit=False)
            voter = voterForm.save(commit=False)
            voter.admin = user
            user.save()
            
            # Set OTP but DON'T verify - admin will verify manually
            voter.otp = "0000"  # Set default OTP
            voter.verified = False  # NOT verified - admin must verify
            voter.save()
            
            # Redirect to pending verification page
            return redirect(reverse('pending_verification'))
        else:
            messages.error(request, "Provided data failed validation")
            # return account_login(request)
    return render(request, "voting/reg.html", context)


def pending_verification(request):
    """Show pending verification page for newly registered users"""
    context = {
        'page_title': 'Pending Verification'
    }
    return render(request, "voting/voter/pending_verification.html", context)


def account_logout(request):
    user = request.user
    if user.is_authenticated:
        logout(request)
        messages.success(request, "Thank you for visiting us!")
    else:
        messages.error(
            request, "You need to be logged in to perform this action")

    return redirect(reverse("account_login"))
