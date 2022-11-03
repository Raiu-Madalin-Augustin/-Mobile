package com.example.anime

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.anime.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), AnimeItemClickListener
{
    private lateinit var binding: ActivityMainBinding
    private lateinit var animeViewModel: AnimeViewModel

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        animeViewModel = ViewModelProvider(this).get(AnimeViewModel::class.java)
        binding.newAnimeButton.setOnClickListener {
            NewAnimeSheet(null).show(supportFragmentManager, "newTaskTag")
        }
        setRecyclerView()
    }

    private fun setRecyclerView()
    {
        val mainActivity = this
        animeViewModel.animeItems.observe(this){
            binding.recyclerView.apply {
                layoutManager = LinearLayoutManager(applicationContext)
                adapter = AnimeItemAdapter(it, mainActivity)
            }
        }
    }

    override fun editTaskItem(taskItem: Anime)
    {
        NewAnimeSheet(taskItem).show(supportFragmentManager,"newTaskTag")
    }


}







