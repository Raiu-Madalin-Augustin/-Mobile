package com.example.anime

import android.R
import android.os.Bundle
import android.text.Editable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.lifecycle.ViewModelProvider
import com.example.anime.databinding.FragmentNewAnimeSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment


class NewAnimeSheet(var anime: Anime?) : BottomSheetDialogFragment()
{
    private lateinit var binding: FragmentNewAnimeSheetBinding
    private lateinit var animeViewModel: AnimeViewModel

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activity = requireActivity()

        if(anime!=null){
            binding.addTitle.text = "Edit Anime"
            binding.addBtn.text= "Edit"
            var editable = Editable.Factory.getInstance()
            binding.name.text = editable.newEditable(anime!!.name)
            binding.genre.text = editable.newEditable(anime!!.genre)
            binding.seasonsWatched.text = editable.newEditable(anime!!.numberOfSeasonsWatched.toString())
            binding.episodesWatched.text = editable.newEditable(anime!!.numberOfEpisodesWatched.toString())
            binding.genre.text = editable.newEditable(anime!!.genre.toString())
        }else{
            binding.deletebtn.visibility= View.INVISIBLE
            binding.deletebtn.isClickable= false
            binding.deletebtn.isEnabled = false
            binding.addBtn.text = "Add"
            binding.addTitle.text = "Add Anime"
        }


        animeViewModel = ViewModelProvider(activity).get(AnimeViewModel::class.java)
        binding.addBtn.setOnClickListener {
            saveAction()
        }
        binding.deletebtn.setOnClickListener{
            deleteAction()
        }
        val ratings = arrayOf(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
        val aa = ArrayAdapter(requireContext(), R.layout.simple_spinner_item, ratings)
        aa.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        with(binding.rating)
        {
            adapter = aa
            setSelection(0)

        }

    }



    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentNewAnimeSheetBinding.inflate(inflater,container,false)
        return binding.root
    }

    private fun deleteAction() {
        binding.name.setText("")
        binding.genre.setText("")
        binding.seasonsWatched.setText("")
        binding.episodesWatched.setText("")
        binding.rating.setSelection(0)
        dismiss()
        animeViewModel.deleteItem(anime!!.id)

    }

    private fun saveAction()
    {
        val name = binding.name.text.toString()
        val genre = binding.genre.text.toString()
        val seasons = binding.seasonsWatched.text.toString().toInt()
        val episodes = binding.episodesWatched.text.toString().toInt()
        val rating = binding.rating.selectedItem.toString().toInt()
        if(anime == null)

        {
            val newTask = Anime(0,name,genre,seasons,episodes,rating)
            animeViewModel.addTaskItem(newTask)
        }
        else
        {
            animeViewModel.updateTaskItem(anime!!.id, name, genre,seasons,episodes,rating)
        }
        binding.name.setText("")
        binding.genre.setText("")
        binding.seasonsWatched.setText("")
        binding.episodesWatched.setText("")
        binding.rating.setSelection(0)
        dismiss()
    }

}








