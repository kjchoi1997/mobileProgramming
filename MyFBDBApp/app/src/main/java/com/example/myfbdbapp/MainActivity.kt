package com.example.myfbdbapp

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.myfbdbapp.databinding.ActivityMainBinding
import com.firebase.ui.database.FirebaseRecyclerOptions
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase

class MainActivity : AppCompatActivity() {
    lateinit var binding: ActivityMainBinding
    lateinit var layoutManager: LinearLayoutManager
    lateinit var adapter: MyProductAdapter
    lateinit var rdb: DatabaseReference
    var findQuery = false
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init(){
        layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        rdb = FirebaseDatabase.getInstance().getReference("Products/items")
        val query = rdb.limitToLast(50)
       // val query = rdb.orderByKey()
        val option = FirebaseRecyclerOptions.Builder<Product>()
            .setQuery(query, Product::class.java)
            .build()
        adapter = MyProductAdapter(option)
        adapter.itemClickListener = object : MyProductAdapter.OnItemClickListener{
            override fun OnItemClick(view: View, position: Int) {
                binding.apply{
                    pIdEdit.setText(adapter.getItem(position).pId.toString())
                    pNameEdit.setText(adapter.getItem(position).pName.toString())
                    pQuantityEdit.setText(adapter.getItem(position).pQuantity.toString())
                }
            }

        }
        binding.apply {
            recyclerView.layoutManager = layoutManager
            recyclerView.adapter = adapter
            //val query
            insertbtn.setOnClickListener {
                initAdapter()
                val item = Product(pIdEdit.text.toString().toInt(),
                pNameEdit.text.toString(), pQuantityEdit.text.toString().toInt())
                rdb.child(pIdEdit.text.toString()).setValue(item)
                clearInput()
            }
            findbtn.setOnClickListener {
                if(!findQuery)
                    findQuery = true
                if(adapter!=null)
                    adapter.stopListening()
                val query = rdb.orderByChild("pname").equalTo(pNameEdit.text.toString())
                val option = FirebaseRecyclerOptions.Builder<Product>()
                    .setQuery(query, Product::class.java)
                    .build()
                adapter = MyProductAdapter(option)
                adapter.itemClickListener = object : MyProductAdapter.OnItemClickListener{
                    override fun OnItemClick(view: View, position: Int) {
                        binding.apply{
                            pIdEdit.setText(adapter.getItem(position).pId.toString())
                            pNameEdit.setText(adapter.getItem(position).pName.toString())
                            pQuantityEdit.setText(adapter.getItem(position).pQuantity.toString())
                        }
                    }

                }
                recyclerView.adapter = adapter
                adapter.startListening()
                clearInput()
            }
            deletebtn.setOnClickListener {
                initAdapter()
                rdb.child(pIdEdit.text.toString()).removeValue()
                clearInput()
            }
            updatebtn.setOnClickListener {
                initAdapter()
                rdb.child(pIdEdit.text.toString())
                    .child("pquantity")
                    .setValue(pQuantityEdit.text.toString().toInt())
                clearInput()
            }
        }
    }
    fun clearInput(){
        binding.apply {
            pIdEdit.text.clear()
            pNameEdit.text.clear()
            pQuantityEdit.text.clear()
        }
    }

    fun initAdapter(){
        if(findQuery){
            findQuery = false
            if(adapter!=null)
                adapter.startListening()
            val query = rdb.limitToLast(50)
            // val query = rdb.orderByKey()
            val option = FirebaseRecyclerOptions.Builder<Product>()
                .setQuery(query, Product::class.java)
                .build()
            adapter = MyProductAdapter(option)
            adapter.itemClickListener = object : MyProductAdapter.OnItemClickListener{
                override fun OnItemClick(view: View, position: Int) {
                    binding.apply{
                        pIdEdit.setText(adapter.getItem(position).pId.toString())
                        pNameEdit.setText(adapter.getItem(position).pName.toString())
                        pQuantityEdit.setText(adapter.getItem(position).pQuantity.toString())
                    }
                }

            }
            binding.recyclerView.adapter = adapter
            adapter.startListening()
        }
    }

    override fun onStart() {
        super.onStart()
        adapter.startListening()
    }

    override fun onStop() {
        super.onStop()
        adapter.stopListening()
    }
}