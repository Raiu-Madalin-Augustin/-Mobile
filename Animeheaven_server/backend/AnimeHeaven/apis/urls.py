from django.urls import path
from .views import ListAnimes, DetailAnimes

urlpatterns = [
    path('', ListAnimes.as_view()),
    path('<int:pk>/', DetailAnimes.as_view())
]
