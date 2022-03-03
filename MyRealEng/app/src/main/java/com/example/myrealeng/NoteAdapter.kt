package com.example.myrealeng

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class NoteAdapter(val items: ArrayList<String>, val item2: ArrayList<String>):RecyclerView.Adapter<NoteAdapter.MyViewHolder>() {


    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView){//오버라이딩한함수들이 밑에있음
        var noteword: TextView =itemView.findViewById(R.id.noteword)
        var notemean: TextView =itemView.findViewById(R.id.notemean)

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NoteAdapter.MyViewHolder {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        val v= LayoutInflater.from(parent.context).inflate(R.layout.row3, parent, false)
        return MyViewHolder(v)//bindviewholder로 넘어감
    }

    override fun getItemCount(): Int {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        return items.size
    }

    override fun onBindViewHolder(holder: NoteAdapter.MyViewHolder, position: Int) {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        holder.noteword.text=items[position]
        holder.notemean.text=item2[position]

    }

}