package com.example.myrealeng

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class ListAdapter(val items: ArrayList<String>): RecyclerView.Adapter<ListAdapter.MyViewHolder>() {

    interface OnItemClickListener{//이벤트처리를 위한 리시너만들기위해 인터페이스 만들기
        fun OnItemClick(holder: MyViewHolder, view: View, data:String, position: Int)
    }

    var itemClickListener:OnItemClickListener?=null//클릭리스너의 객체생성


    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView){//오버라이딩한함수들이 밑에있음
        var vocaword: TextView =itemView.findViewById(R.id.vocaword)
        var vocameaning: TextView=itemView.findViewById(R.id.vocameaning)
        init{//클릭리스너를 초기화
            itemView.setOnClickListener{
                itemClickListener?.OnItemClick(this, it, items[adapterPosition], adapterPosition)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListAdapter.MyViewHolder {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        val v= LayoutInflater.from(parent.context).inflate(R.layout.row2, parent, false)
        return MyViewHolder(v)//bindviewholder로 넘어감
    }

    override fun getItemCount(): Int {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        return items.size
    }

    override fun onBindViewHolder(holder: ListAdapter.MyViewHolder, position: Int) {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        holder.vocaword.text=items[position]
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