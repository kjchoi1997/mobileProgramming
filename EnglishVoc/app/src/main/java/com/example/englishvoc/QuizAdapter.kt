package com.example.englishvoc

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class QuizAdapter(val items:ArrayList<String>): RecyclerView.Adapter<QuizAdapter.MyViewHolder>() {

    interface OnItemClickListener{
        fun OnItemClick(holder: MyViewHolder, view: View, data:String, position: Int)
    }

    var itemClickListener:OnItemClickListener?=null


    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView){
    var quizanswer: TextView =itemView.findViewById(R.id.quizanswer)
        init{
            itemView.setOnClickListener{
                itemClickListener?.OnItemClick(this, it, items[adapterPosition], adapterPosition)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): QuizAdapter.MyViewHolder {
        val v= LayoutInflater.from(parent.context).inflate(R.layout.fragment_quiz_item, parent, false)
        return MyViewHolder(v)
    }

    override fun getItemCount(): Int {
        return items.size
    }

    override fun onBindViewHolder(holder: QuizAdapter.MyViewHolder, position: Int) {
        holder.quizanswer.text=items[position]
    }
}