package com.example.englishvoc

import android.os.Build
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.RequiresApi
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import com.example.englishvoc.databinding.FragmentItemListBinding
import java.util.*
import kotlin.collections.ArrayList

class VocFragment : Fragment() {

    var binding :FragmentItemListBinding? = null
    private val _binding : FragmentItemListBinding get() = binding!!
    var data: ArrayList<MyData> = ArrayList()
    lateinit var adapter: MyVocRecyclerViewAdapter
    lateinit var tts:TextToSpeech
    lateinit var recyclerView: RecyclerView
    var isTtsReady = false

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentItemListBinding.inflate(inflater, container, false)
        return _binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initData()
        initRecyclerView()
        initTTs()
    }



    private fun initRecyclerView() {
        recyclerView = _binding.recyclerView
        adapter = MyVocRecyclerViewAdapter(data)
        adapter.itemClickListener = object : MyVocRecyclerViewAdapter.OnItemClickListener{
            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
            override fun OnItemClick(
                holder: MyVocRecyclerViewAdapter.ViewHolder,
                view: View,
                data: MyData,
                position: Int
            ) {
                if(isTtsReady)
                    tts.speak(data.word, TextToSpeech.QUEUE_ADD, null, null)

            }

        }
        recyclerView.adapter = adapter

        val simpleCallback = object:ItemTouchHelper.SimpleCallback(ItemTouchHelper.DOWN or ItemTouchHelper.UP, ItemTouchHelper.RIGHT){
            override fun onMove(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, target: RecyclerView.ViewHolder): Boolean {
                adapter.moveItem(viewHolder.bindingAdapterPosition, target.bindingAdapterPosition)
                return true
            }

            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
                adapter.removeItem(viewHolder.bindingAdapterPosition)
            }

        }
        val itemTouchHelper = ItemTouchHelper(simpleCallback)
        itemTouchHelper.attachToRecyclerView(recyclerView)
    }


    private fun readFileScan(scan: Scanner) {
        val show:Boolean = false
        while(scan.hasNextLine()){
            val word=scan.nextLine()
            val meaning=scan.nextLine()
            data.add(MyData(word, meaning, show))
        }
        scan.close()
    }

    private fun initTTs(){
        tts = TextToSpeech(activity, TextToSpeech.OnInitListener {
            isTtsReady = true
            tts.language = Locale.US
        })
    }


    private fun initData() {
        try {
            val scan2 = Scanner(requireActivity().openFileInput("out.txt"))
            readFileScan(scan2)
        }catch(e:Exception){

        }
        val scan = Scanner(resources.openRawResource(R.raw.words))
        readFileScan(scan)
    }



}