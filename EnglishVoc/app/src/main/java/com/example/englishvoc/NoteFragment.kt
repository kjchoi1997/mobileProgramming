package com.example.englishvoc

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.englishvoc.databinding.FragmentNoteBinding
import java.util.*

class NoteFragment : Fragment() {
    var binding: FragmentNoteBinding?=null
    var wordarray=ArrayList<String>()
    var meanarray=ArrayList<String>()
    lateinit var adapter : NoteAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentNoteBinding.inflate(layoutInflater, container, false)
        init()
        binding!!.apply {
            renewbtn.setOnClickListener {
                wordarray.clear()
                meanarray.clear()
                noterecycle?.adapter?.notifyDataSetChanged()
                init()
            }
        }
        return binding!!.root
    }

    private fun init() {
        readfile()
        binding!!.apply {
            noterecycle.layoutManager = LinearLayoutManager(requireActivity(), LinearLayoutManager.VERTICAL, false)
            adapter = NoteAdapter(wordarray, meanarray)
            noterecycle.adapter = adapter
        }
    }

    fun readfile(){
        val scan= Scanner(requireActivity().openFileInput("note.txt"))
        while(scan.hasNextLine()){
            val word=scan.nextLine()
            val mean=scan.nextLine()
            wordarray.add(word)
            meanarray.add(mean)
        }
    }

}
