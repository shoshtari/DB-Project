from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.db.models import Q

ROLE_CHOICES = (
    (0, 'Employee Real'),
    (1, 'Employee Legal'),
    (2, 'Employer Legal'),
    (3, 'Employer Real'),
)
LEVEL_CHOICES = (
    (0, 'Beginner'),
    (1, 'Intermediate'),
    (2, 'Junior'),
    (3, 'Senior'),
    (4, 'Expert'),
    (5, 'Master'),
    (6, 'Grand Master'),
    (7, 'Legendary'),
    (8, 'None'),
)
GENDER_CHOICES = (
    (0, 'male'),
    (1, 'female')
)

GRADE_CHOICES = (
    (0, 'none'),
    (1, 'primary'),
    (2, 'secondary'),
    (3, 'high school'),
    (4, 'bachelor'),
    (5, 'master'),
    (6, 'doctor'),
    (7, 'professor'),
)


class Degree(models.Model):
    degree = models.IntegerField(choices=GRADE_CHOICES, default=0)
    major = models.CharField(max_length=20, null=True, blank=True)
    school = models.CharField(max_length=20, null=True, blank=True)
    score = models.CharField(max_length=20, null=True, blank=True)

    def __str__(self):
        return self.degree

class PhoneNum(models.Model):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    def __str__(self):
        return self.phone_number
    
class EmailAddress(models.Model):
    email_address = models.CharField(max_length=50, null=True, blank=True)
    def __str__(self):
        return self.email_address

class CustomUser(AbstractUser):
    user_role = models.IntegerField(choices=ROLE_CHOICES, default=0)
    phone_number = models.ForeignKey(PhoneNum, on_delete=models.CASCADE, null=True, blank=True)
    email_address = models.ForeignKey(EmailAddress, on_delete=models.CASCADE, null=True, blank=True)
    address = models.CharField(max_length=100, null=True, blank=True)
    
    # --- employee ---
    level = models.IntegerField(choices=LEVEL_CHOICES, default=8)
    gender = models.IntegerField(choices=GENDER_CHOICES, default=0)
    birth_date = models.DateField(null=True, blank=True)
    is_married = models.BooleanField(default=False)
    is_working = models.BooleanField(default=False)
    degree = models.ForeignKey(Degree, on_delete=models.CASCADE, null=True, blank=True)
    skills = models.ManyToManyField('jobs.Skill', blank=True)

# ----------------- Employee -----------------
class EmployeeManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        results = super().get_queryset(*args, **kwargs)
        return results.filter(Q(user_role=0) | Q(user_role=1))

class Employee(CustomUser):
    objects = EmployeeManager()
    def __str__(self):
        return self.first_name + " " + self.last_name

    class Meta:
        proxy = True
        verbose_name = "Employee"
        verbose_name_plural = "Employees"

# ----------------- Employer -----------------
class EmployerManager(BaseUserManager):
    def get_queryset(self, *args, **kwargs):
        results = super().get_queryset(*args, **kwargs)
        return results.filter(Q(user_role=2) | Q(user_role=3))
    
class Employer(CustomUser):
    objects = EmployerManager()
    def __str__(self):
        return self.first_name + " " + self.last_name

    class Meta:
        proxy = True
        verbose_name = "Employer"
        verbose_name_plural = "Employers"

