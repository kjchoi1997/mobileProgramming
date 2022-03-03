package com.example.addvocprac

import android.os.Build
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.view.View
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.util.*
import kotlin.collections.ArrayList

class MainActivity : AppCompatActivity() {
    var data: ArrayList<MyData> = ArrayList()
    lateinit var  recyclerView : RecyclerView
    lateinit var  adapter:MyAdapter
    lateinit var  tts: TextToSpeech
    var isTtsReady = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initData()
        initRecyclerView()
        initTTS()
    }

    private fun initTTS() {
        tts = TextToSpeech(this, TextToSpeech.OnInitListener {
            isTtsReady = true
            tts.language = Locale.US
        })
    }

    override fun onStop() {
        super.onStop()
        tts.stop()
    }

    override fun onDestroy() {
        super.onDestroy()
        tts.shutdown()
    }



    private fun initRecyclerView() {
        recyclerView = findViewById<RecyclerView>(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this,
                LinearLayoutManager.VERTICAL, false)
        adapter = MyAdapter(data)
        adapter.itemClickListener = object : MyAdapter.OnItemClickListener{
            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
            override fun OnItemClick(
                    holder: MyAdapter.ViewHolder,
                    view: View,
                    data: MyData,
                    position: Int
            ) {
                if(isTtsReady){
                    tts.speak(data.word, TextToSpeech.QUEUE_ADD, null, null)
                }
                if (holder.textView2.visibility == View.GONE) {
                    holder.textView2.visibility = View.VISIBLE
                } else if (holder.textView2.visibility == View.VISIBLE) {
                    holder.textView2.visibility = View.GONE
                }

                Toast.makeText(applicationContext, data.meaning, Toast.LENGTH_SHORT).show()
            }

        }
        recyclerView.adapter = adapter
        val simpleCallback = object:ItemTouchHelper.SimpleCallback(ItemTouchHelper.DOWN or ItemTouchHelper.UP,
                ItemTouchHelper.RIGHT){
            override fun onMove(
                    recyclerView: RecyclerView,
                    viewHolder: RecyclerView.ViewHolder,
                    target: RecyclerView.ViewHolder
            ): Boolean {
                adapter.moveItem(viewHolder.adapterPosition, target.adapterPosition)
                return true
            }

            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
                adapter.removeItem(viewHolder.adapterPosition)
            }

        }
        val itemTouchHelper = ItemTouchHelper(simpleCallback)
        itemTouchHelper.attachToRecyclerView(recyclerView)
    }
    fun readFileScan(scan:Scanner){
        while(scan.hasNextLine()){
            val word = scan.nextLine()
            val meaning = scan.nextLine()
            data.add(MyData(word, meaning))
        }
    }

    private fun initData() {
        try {
            val scan2 = Scanner(openFileInput("out.txt"))
            readFileScan(scan2)
        }catch(e:Exception){
        }
        val scan = Scanner(resources.openRawResource(R.raw.words))
        readFileScan(scan)
    }
}