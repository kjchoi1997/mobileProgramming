package com.example.kuvid.news

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.kuvid.databinding.RowBinding

class MyAdapter (val items:ArrayList<MyNewsData>)
    : RecyclerView.Adapter<MyAdapter.MyViewHolder>(){
    interface OnItemClickListener {
        fun onItemClick(holder: MyViewHolder, view: View, data: MyNewsData, position: Int)
    }

    var itemClickListener: OnItemClickListener?=null;
    inner class MyViewHolder(val binding: RowBinding):RecyclerView.ViewHolder(binding.root){
        init{
            binding.newstitle.setOnClickListener{
                itemClickListener?.onItemClick(this, it, items[adapterPosition], adapterPosition)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val view = RowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return MyViewHolder(view)
    }

    override fun getItemCount(): Int {
        return items.size
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.binding.newstitle.text = items[position].newstitle
    }


}