package com.example.anime

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.anime.databinding.AnimeItemCellBinding

class AnimeItemAdapter(
    private val taskItems: List<Anime>,
    private val clickListener: AnimeItemClickListener
): RecyclerView.Adapter<AnimeItemViewHolder>()
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): AnimeItemViewHolder {
        val from = LayoutInflater.from(parent.context)
        val binding = AnimeItemCellBinding.inflate(from, parent, false)
        return AnimeItemViewHolder(parent.context, binding, clickListener)
    }

    override fun onBindViewHolder(holder: AnimeItemViewHolder, position: Int) {
        holder.bindTaskItem(taskItems[position])
    }

    override fun getItemCount(): Int = taskItems.size
}