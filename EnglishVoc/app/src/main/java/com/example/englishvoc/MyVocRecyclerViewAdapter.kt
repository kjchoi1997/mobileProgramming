package com.example.englishvoc

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class MyVocRecyclerViewAdapter(
    private val items: ArrayList<MyData>
) : RecyclerView.Adapter<MyVocRecyclerViewAdapter.ViewHolder>() {

    interface OnItemClickListener{
        fun OnItemClick(holder: ViewHolder, view: View, data:MyData, position: Int)
    }

    var itemClickListener:OnItemClickListener?=null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.word.text = items[position].word
        holder.meaning.text = items[position].meaning
        if(!items[position].show){
            holder.meaning.visibility = View.GONE
        }
        else{
            holder.meaning.visibility = View.VISIBLE
        }
    }

    override fun getItemCount(): Int{
        return items.size
    }

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        var word: TextView = view.findViewById(R.id.vocaword)
        var meaning: TextView = view.findViewById(R.id.vocameaning)
        init{
            view.setOnClickListener{
                itemClickListener?.OnItemClick(this, it, items[adapterPosition], adapterPosition)
                if (meaning.visibility == View.GONE) {
                    items[adapterPosition].show = true
                    meaning.visibility = View.VISIBLE
                } else if (meaning.visibility == View.VISIBLE) {
                    items[adapterPosition].show = false
                    meaning.visibility = View.GONE
                }
            }
        }
        override fun toString(): String {
            return super.toString() + " '" + word.text + "'"
        }
    }

    fun moveItem(oldPos: Int, newPos:Int) {
        val item=items.get(oldPos)
        items.removeAt(oldPos)
        items.add(newPos, item)
        notifyItemMoved(oldPos, newPos)
    }

    fun removeItem(pos:Int){
        items.removeAt(pos)
        notifyItemRemoved(pos)
    }
}