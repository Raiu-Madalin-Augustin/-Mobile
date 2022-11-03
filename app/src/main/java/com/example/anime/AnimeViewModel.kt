package com.example.anime

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class AnimeViewModel : ViewModel() {
    var animeItems = MutableLiveData<MutableList<Anime>>()

    init {
        animeItems.value = mutableListOf()
        animeItems.value!!.add(Anime(0,"Naruto","Action",2,40,8))
    }

    fun addTaskItem(newTask: Anime) {
        val list = animeItems.value
        newTask.id = animeItems.value!!.size
        list!!.add(newTask)
        animeItems.postValue(list)
    }

    fun updateTaskItem(
        id: Int,
        name: String,
        genre: String,
        seasons: Int,
        episodes: Int,
        rating: Int
    ) {
        val list = animeItems.value
        val task = list!!.find { it.id == id }!!
        task.name = name
        task.genre = genre
        task.numberOfSeasonsWatched = seasons
        task.numberOfEpisodesWatched = episodes
        task.rating = rating

        animeItems.postValue(list)
    }

    fun deleteItem(id: Int) {
        val list = animeItems.value
        val anime = list!!.find { it.id == id }
        list!!.remove(anime)

        animeItems.postValue(list)

    }


}