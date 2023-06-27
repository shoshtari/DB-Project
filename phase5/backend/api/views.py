from jobs.models import Job, Score, Skill, JobOffer
from django.contrib.auth import get_user_model

from .serializers import UserSerializer, JobSerializer, JobOfferSerializer, ScoreSerializer, SkillSerializer
# from .permissions import (
#     IsSuperUser,
#     IsAuthorAndDraftOrReadOnly
# )

from rest_framework.viewsets import ModelViewSet

class UserViewSET(ModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer

class JobViewSET(ModelViewSet):
    queryset = Job.objects.all()
    serializer_class = JobSerializer
    # permission_classes = [IsAuthorAndDraftOrReadOnly]
    # filterset_fields = ['status', 'author']
    # ordering_fields = ['publish', 'status', 'updated', 'hits__count']
    # ordering = ['-publish']
    # search_fields = [
    #                     'title',
    #                     'description',
    #                     'catagory__title',
    #                     'author__username',
    #                     'author__first_name',
    #                     'author__last_name', 
    #                 ]

class JobOfferViewSET(ModelViewSet):
    queryset = JobOffer.objects.all()
    serializer_class = JobOfferSerializer

class ScoreViewSET(ModelViewSet):
    queryset = Score.objects.all()
    serializer_class = ScoreSerializer

class SkillViewSET(ModelViewSet):
    queryset = Skill.objects.all()
    serializer_class = SkillSerializer
