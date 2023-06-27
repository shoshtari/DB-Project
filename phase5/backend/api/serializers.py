from rest_framework.serializers import ModelSerializer, SerializerMethodField
from jobs.models import Job, Score, Skill, JobOffer
from django.contrib.auth import get_user_model
from drf_dynamic_fields import DynamicFieldsMixin

class UserSerializer(DynamicFieldsMixin, ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = "__all__" 


class JobSerializer(DynamicFieldsMixin, ModelSerializer):
    # author = AuthorSerializer()

    # def get_author(self, obj):
    #     return {
    #         "pk": obj.author.pk,
    #         "username": obj.author.username,
    #         "first_name": obj.author.first_name,
    #         "last_name": obj.author.last_name,
    #     }
    # author = SerializerMethodField("get_author") 
    class Meta:
        model = Job
        fields = "__all__"

class JobOfferSerializer(DynamicFieldsMixin, ModelSerializer):
    class Meta:
        model = JobOffer
        fields = "__all__"


class ScoreSerializer(DynamicFieldsMixin, ModelSerializer):
    class Meta:
        model = Score
        fields = "__all__"

class SkillSerializer(DynamicFieldsMixin, ModelSerializer):
    class Meta:
        model = Skill
        fields = "__all__"


