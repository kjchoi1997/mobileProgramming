package com.example.a201712099

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.util.*
import kotlin.collections.ArrayList

class kjchoiMainActivity : AppCompatActivity() {
    var data:ArrayList<kjchoiMyData> = ArrayList()
    lateinit var  recyclerView: RecyclerView
    lateinit var  adapter: kjchoiMyAdapter
    val ADD_LIST = 200
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_kjchoi_main)
        initData()
        initRecyclerView()
    }


    private fun initRecyclerView() {
        recyclerView = findViewById<RecyclerView>(R.id.mainrecyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL,false)
        adapter = kjchoiMyAdapter(data)
        adapter.itemClickListener = object:kjchoiMyAdapter.OnItemClickListener{
            override fun OnItemClick(
                holder: kjchoiMyAdapter.ViewHolder,
                view: View,
                data: kjchoiMyData,
                position: Int
            ) {
                Toast.makeText(applicationContext, data.price, Toast.LENGTH_SHORT).show()
                val intent = Intent()
                intent.putExtra("voc", kjchoiMyData(data.name, data.price))
                setResult(Activity.RESULT_OK,intent)
                finish()
            }
        }
        recyclerView.adapter = adapter
    }

    private fun initData(){
        try {
            val scan = Scanner(resources.openRawResource(R.raw.kjchoi))
            while (scan.hasNextLine()) {
                val name = scan.nextLine()
                val price = scan.nextLine()
                data.add(kjchoiMyData(name, price))
            }
        }catch (e:Exception){
            Toast.makeText(this, "파일 못읽어옴", Toast.LENGTH_SHORT).show()
        }

    }

}