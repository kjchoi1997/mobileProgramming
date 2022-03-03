package com.example.my_english_word.Adapter

import android.util.Log
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import com.example.my_english_word.MyData
import com.example.my_english_word.R
import kotlinx.android.synthetic.main.fragment_short_exam.view.*


import kotlinx.android.synthetic.main.fragment_word.view.*
import java.lang.Math.abs


class MyWordRecyclerViewAdapter(
    private val items: List<MyData>
) : RecyclerView.Adapter<MyWordRecyclerViewAdapter.ViewHolder>() {

    interface OnClickWordListner{
        fun onClickFavor(data: MyData)
        fun onClickWord(data: MyData)
    }

    var clickWordListner : OnClickWordListner?= null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_word, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = items[position]
        holder.wordView.text= item.word
        if(item.favorite == 1) holder.addFavorBtn.setChecked(true)
        else holder.addFavorBtn.setChecked(false)
    }

    override fun getItemCount(): Int = items.size

    inner class ViewHolder(val mView: View) : RecyclerView.ViewHolder(mView) {
        val wordView: TextView = mView.wordView
        val addFavorBtn = mView.addFavorBtn

        init{
            wordView.setOnClickListener {
                clickWordListner?.onClickWord(items[adapterPosition])
            }

            addFavorBtn.setOnClickListener {
                clickWordListner?.onClickFavor(items[adapterPosition])
                items[adapterPosition].favorite = abs(items[adapterPosition].favorite-1)
                notifyItemChanged(adapterPosition)
            }
        }

        override fun toString(): String {
            return super.toString() + " '" + wordView.text + "'"
        }
    }
}
