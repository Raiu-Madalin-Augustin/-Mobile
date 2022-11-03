package com.example.anime

import android.content.Context
import androidx.recyclerview.widget.RecyclerView
import com.example.anime.databinding.AnimeItemCellBinding

class AnimeItemViewHolder(
    private val context: Context,
    private val binding: AnimeItemCellBinding,
    private val clickListener: AnimeItemClickListener
): RecyclerView.ViewHolder(binding.root)
{

    fun bindTaskItem(anime: Anime)
    {
        binding.tvName.text = anime.name
        binding.tvGenre.text = anime.genre
        binding.tvSeasonsWatched.text = anime.numberOfSeasonsWatched.toString()
        binding.tvEpisodesWatched.text = anime.numberOfEpisodesWatched.toString()
        binding.tvRating.text = anime.rating.toString()

        binding.taskCellContainer.setOnClickListener{
            clickListener.editTaskItem(anime)
        }
    }
}