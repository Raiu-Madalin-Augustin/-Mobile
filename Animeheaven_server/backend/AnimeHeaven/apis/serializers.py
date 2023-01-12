from rest_framework import serializers
from animes import models

class AnimeSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'name',
            'genre',
            'numberOfSeasonsWatched',
            'numberOfEpisodesWatched',
            'rating'
        )
        model = models.Anime