from django.db import models


class Anime(models.Model):
    name = models.CharField(max_length=100, default="")
    genre = models.CharField(max_length=100, default="")
    numberOfSeasonsWatched = models.IntegerField(default=0)
    numberOfEpisodesWatched = models.IntegerField(default=0)
    rating = models.IntegerField(default=0)

    def __str__(self) -> str:
        return str(self.name) + " " + str(self.genre) + " " + str(self.numberOfSeasonsWatched) + " " + str(self.numberOfEpisodesWatched) + " " + str(self.rating)
