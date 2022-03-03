package com.example.myrealeng

import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.fragment_voca.*
import java.io.File
import java.util.*
import kotlin.collections.ArrayList

/**
 * A simple [Fragment] subclass.
 */
class VocaFragment : Fragment() {

    var words= mutableMapOf<String, String>()//단어와 뜻을 모두 포함
    var array=ArrayList<String>()//단어만 포함
    lateinit var adapter: ListAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_voca, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        init()
    }

    private fun init() {
        readFile()
        vocarecycle.layoutManager= LinearLayoutManager(activity, LinearLayoutManager.VERTICAL, false)//밑에 어뎁터를 하나 만들어 주는게 아니라 어뎁터 객체 하나 생성
        adapter= ListAdapter(array)
        adapter.itemClickListener=object :ListAdapter.OnItemClickListener{//인터페이스를 달아주면 자동으로 오버라이딩 인벤트처리 리스너를 달아줌
        override fun OnItemClick(holder: ListAdapter.MyViewHolder, view: View, data: String, position: Int)
        {
            holder.vocameaning.text=words[data]
            if(holder.vocameaning.visibility==View.VISIBLE){
                holder.vocameaning.visibility=View.GONE
            }
            else{
                holder.vocameaning.visibility=View.VISIBLE
            }
        }

        }
        vocarecycle.adapter=adapter

        val simpleCallback=object :
            ItemTouchHelper.SimpleCallback(ItemTouchHelper.DOWN or ItemTouchHelper.UP, ItemTouchHelper.RIGHT)//스와이프 드래그앤드랍 객체생성, (드래그앤드랍, 스와이프)
        {
            override fun onMove(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, target: RecyclerView.ViewHolder
            ): Boolean//move의 경우 어뎁터를 변경해야함->어뎁터클래스로이동 함수하나생성
            {
                adapter.moveItem(viewHolder.adapterPosition, target.adapterPosition)
                return true
            }

            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
                adapter.removeItem(viewHolder.adapterPosition)
            }

        }
        val itemTouchHelper= ItemTouchHelper(simpleCallback)
        itemTouchHelper.attachToRecyclerView(vocarecycle)//꼭 달아줄것
    }


    fun readFile(){
        val scan2 = Scanner(requireActivity().openFileInput("out.txt"))
        readFileScan(scan2)

        val scan= Scanner(resources.openRawResource(R.raw.words))//파일을 읽어오는 스캐너 객체
        readFileScan(scan)
    }


    fun readFileScan(scan: Scanner){
        while(scan.hasNextLine()){
            val word=scan.nextLine()
            val meaning=scan.nextLine()
            words[word]=meaning
            array.add(word)
        }
        scan.close()
    }

}
