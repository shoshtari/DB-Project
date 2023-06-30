from django.urls import path, include
from rest_framework import routers
from .views import (
    UserViewSET,
    JobViewSET,
    JobOfferViewSET,
    ScoreViewSET,
    SkillViewSET,
    )

app_name = "api"

router = routers.SimpleRouter()
router.register(r'users', UserViewSET, basename="users")
router.register(r'jobs', JobViewSET, basename="jobs")
router.register(r'skills', SkillViewSET, basename="skills")
router.register(r'joboffers', JobOfferViewSET, basename="joboffers")
router.register(r'scores', ScoreViewSET, basename="scores")

# urlpatterns = router.urls
urlpatterns = [
    path("", include(router.urls)),
    path("search/", include("rest_framework.urls")),
]
