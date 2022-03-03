package com.example.testprac

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

class MainActivity : AppCompatActivity() {
    var data:ArrayList<MyData> = ArrayList()
    lateinit var  recyclerView: RecyclerView
    lateinit var  adapter: MyAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initData()
        initRecyclerView()
    }

    private fun initRecyclerView() {
        recyclerView = findViewById<RecyclerView>(R.id.mainRecyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL,false)
        adapter = MyAdapter(data)
        adapter.itemClickListener = object:MyAdapter.OnItemClickListener{
            override fun OnItemClick(
                holder: MyAdapter.ViewHolder,
                view: View,
                data: MyData,
                position: Int
            ) {
                Toast.makeText(applicationContext, data.price, Toast.LENGTH_SHORT).show()
                val intent = Intent()
                intent.putExtra("voc", MyData(data.name, data.price))
                setResult(Activity.RESULT_OK, intent)
                finish()
            }
        }
        recyclerView.adapter = adapter
    }

    private fun initData() {
        try {
            val scan = Scanner(resources.openRawResource(R.raw.test))
            while (scan.hasNextLine()) {
                val name = scan.nextLine()
                val price = scan.nextLine()
                data.add(MyData(name, price))
            }
        }catch (e:Exception){
            Toast.makeText(this, "파일 못읽어옴", Toast.LENGTH_SHORT).show()
        }
    }
}