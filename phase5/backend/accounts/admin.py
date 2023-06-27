from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import CustomUser, Employee, Employer, PhoneNum, EmailAddress, Degree

class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = ['username', 'email', 'user_role']
    fieldsets = UserAdmin.fieldsets + (
            ('PUBLIC', {'fields': ('user_role','address')}),
            ('Employee info', {'fields': ('is_married', 'is_working', 'degree', 'birth_date', 'gender', 'level')}),
    )
# admin.site.register(CustomUser, CustomUserAdmin)
admin.site.register(Employee, CustomUserAdmin)


class EmployerAdmin(UserAdmin):
    model = CustomUser
    list_display = ['username', 'email', 'user_role']
    fieldsets = UserAdmin.fieldsets + (
            ('PUBLIC', {'fields': ('user_role','address')}),

    )
admin.site.register(Employer, EmployerAdmin)


class PhoneNumAdmin(admin.ModelAdmin):
    list_display = ['phone_number']
admin.site.register(PhoneNum, PhoneNumAdmin)


class EmailAddressAdmin(admin.ModelAdmin):
    list_display = ['email_address']
admin.site.register(EmailAddress, EmailAddressAdmin)


class DegreeAdmin(admin.ModelAdmin):
    list_display = ['degree']
admin.site.register(Degree, DegreeAdmin)

