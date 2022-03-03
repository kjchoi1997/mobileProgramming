package com.example.myrealeng

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.fragment_note.*
import java.io.File
import java.util.*

/**
 * A simple [Fragment] subclass.
 */
class NoteFragment : Fragment() {

    var wordarray=ArrayList<String>()//단어만 포함
    var meanarray=ArrayList<String>()
    lateinit var adapter : NoteAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_note, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        init()
        renewbtn.setOnClickListener {
            wordarray.clear()
            meanarray.clear()
            noterecycle?.adapter?.notifyDataSetChanged()
            init()
        }

    }

    private fun init() {
        readfile()
        noterecycle.layoutManager=LinearLayoutManager(activity!!, LinearLayoutManager.VERTICAL, false)
        adapter=NoteAdapter(wordarray, meanarray)
        noterecycle.adapter=adapter
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
