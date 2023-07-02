from django.db import models
from accounts.models import LEVEL_CHOICES, GRADE_CHOICES


GENDER_CHOICES = (
    (0, 'male'),
    (1, 'female'),
    (2, 'not important')
)

class Skill(models.Model):
    name = models.CharField(max_length=50, unique=True)
    is_verified = models.BooleanField(default=False)

    def __str__(self):
        return self.name
    
    class Meta:
        verbose_name = "Skill"
        verbose_name_plural = "Skills"

class Job(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField(null=True, blank=True)
    skills = models.ManyToManyField(Skill,null=True, blank=True)
    required_level = models.IntegerField(choices=LEVEL_CHOICES, default=8)
    required_gender = models.IntegerField(choices=GENDER_CHOICES, default=0)
    benefit = models.TextField(null=True, blank=True)
    is_remote = models.BooleanField(default=False)
    recommended_salary = models.IntegerField(default=0)
    address = models.CharField(max_length=100, null=True, blank=True)
    employer = models.ForeignKey('accounts.Employer', on_delete=models.CASCADE)
    required_graduation = models.IntegerField(choices=GRADE_CHOICES, default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return self.title
    
    class Meta:
        verbose_name = "Job"
        verbose_name_plural = "Jobs"


class JobOffer(models.Model):
    job = models.ForeignKey(Job, on_delete=models.CASCADE)
    employee = models.ForeignKey('accounts.Employee', on_delete=models.CASCADE)
    is_accepted = models.BooleanField(default=False)
    is_rejected = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.job.title + " - " + self.employee.first_name + " " + self.employee.last_name
    
    # def save(self, *args, **kwargs):
    #     if self.is_accepted:
    #         self.job.is_active = False
    #         self.job.save()
    #     super(JobOffer, self).save(*args, **kwargs)

    class Meta:
        verbose_name = "Job Offer"
        verbose_name_plural = "Job Offers"

        constraints = [
            models.UniqueConstraint(fields=['job', 'employee'], name='unique_job_offer'),
            models.CheckConstraint(check=~models.Q(is_accepted=True, is_rejected=True), name='check_accepted_rejected'),
        ]

class Score(models.Model):
    employee = models.ForeignKey('accounts.Employee', on_delete=models.CASCADE)
    job = models.ForeignKey(Job, on_delete=models.CASCADE)
    score = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.employee.first_name + " " + self.employee.last_name + " - " + self.job.title
    
    class Meta:
        verbose_name = "Score"
        verbose_name_plural = "Scores"
        constraints = [
            models.UniqueConstraint(fields=['employee', 'job'], name='unique_score'),
        ]