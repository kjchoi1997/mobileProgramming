package com.example.myrealeng

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class QuizAdapter(val items:ArrayList<String>): RecyclerView.Adapter<QuizAdapter.MyViewHolder>() {

    interface OnItemClickListener{//이벤트처리를 위한 리시너만들기위해 인터페이스 만들기
    fun OnItemClick(holder: MyViewHolder, view: View, data:String, position: Int)
    }

    var itemClickListener:OnItemClickListener?=null//클릭리스너의 객체생성


    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView){//오버라이딩한함수들이 밑에있음
        var answer1: TextView =itemView.findViewById(R.id.answer1)
        init{//클릭리스너를 초기화
            itemView.setOnClickListener{
                itemClickListener?.OnItemClick(this, it, items[adapterPosition], adapterPosition)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): QuizAdapter.MyViewHolder {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        val v= LayoutInflater.from(parent.context).inflate(R.layout.row1, parent, false)
        return MyViewHolder(v)//bindviewholder로 넘어감
    }

    override fun getItemCount(): Int {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        return items.size
    }

    override fun onBindViewHolder(holder: QuizAdapter.MyViewHolder, position: Int) {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        holder.answer1.text=items[position]
    }
}