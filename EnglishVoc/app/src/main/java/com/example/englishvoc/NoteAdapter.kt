package com.example.englishvoc

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class NoteAdapter(val word: ArrayList<String>, val mean: ArrayList<String>):RecyclerView.Adapter<NoteAdapter.MyViewHolder>() {


    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView){
        var noteword: TextView =itemView.findViewById(R.id.noteword)
        var notemean: TextView =itemView.findViewById(R.id.notemean)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NoteAdapter.MyViewHolder {
        val v= LayoutInflater.from(parent.context).inflate(R.layout.fragment_note_item, parent, false)
        return MyViewHolder(v)
    }

    override fun getItemCount(): Int {
        return word.size
    }

    override fun onBindViewHolder(holder: NoteAdapter.MyViewHolder, position: Int) {
        holder.noteword.text=word[position]
        holder.notemean.text=mean[position]

    }

}