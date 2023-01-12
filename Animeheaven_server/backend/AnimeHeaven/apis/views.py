from django.shortcuts import render
from rest_framework import generics
from animes import models
from .serializers import AnimeSerializer

class ListAnimes(generics.ListCreateAPIView):
    queryset = models.Anime.objects.all()
    serializer_class = AnimeSerializer

class DetailAnimes(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Anime.objects.all()
    serializer_class = AnimeSerializer