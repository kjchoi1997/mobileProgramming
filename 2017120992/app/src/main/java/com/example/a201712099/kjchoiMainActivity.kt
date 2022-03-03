package com.example.a201712099

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.a201712099.R
import com.example.a201712099.kjchoiMainActivity2
import com.example.a201712099.kjchoiMyAdapter
import com.example.a201712099.kjchoiMyData
import java.util.*
import kotlin.collections.ArrayList

class MainActivity : AppCompatActivity() {
    var data:ArrayList<kjchoiMyData> = ArrayList()
    lateinit var  recyclerView: RecyclerView
    lateinit var  adapter: kjchoiMyAdapter
    val ADD_LIST = 100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.kjchoiactivity_main)
        initData()
        initRecyclerView()
    }


    private fun initRecyclerView() {
        recyclerView = findViewById<RecyclerView>(R.id.recyclerView)
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
                init()

                finish()
            }
        }
        recyclerView.adapter = adapter
    }
    private fun init(){
        val intent = Intent(this, kjchoiMainActivity2::class.java)
        startActivityForResult(intent, ADD_LIST)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when(requestCode){
            ADD_LIST->{
                if(resultCode == Activity.RESULT_OK){
                }
            }
        }
    }


    private fun initData() {
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