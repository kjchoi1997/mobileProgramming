package com.example.mygetnews

import android.content.Intent
import android.content.Intent.ACTION_VIEW
import android.net.Uri
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.mygetnews.databinding.ActivityMainBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jsoup.Jsoup

class MainActivity : AppCompatActivity() {
    lateinit var binding: ActivityMainBinding
    lateinit var adapter: MyAdapter
    //url
    val url = "https://search.daum.net/search?nil_suggest=sugsch&w=news&DA=GIQ&sq=%EC%BD%94%EB%A1%9C%EB%82%98&o=4&sugo=15&cluster=y&q=%EC%BD%94%EB%A1%9C%EB%82%98+19"
    val scope = CoroutineScope(Dispatchers.IO)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }
    fun getnews(){
        scope.launch {
            adapter.items.clear()
            val doc = Jsoup.connect(url).get()
            val headlines = doc.select("li>div>div>div>a")
            for(news in headlines){
                adapter.items.add(MyData(news.text(), news.absUrl("href")))
            }
            withContext(Dispatchers.Main){
                adapter.notifyDataSetChanged()
                binding.swipe.isRefreshing = false
            }
        }
    }
    private fun init(){
        binding.swipe.setOnRefreshListener{
            binding.swipe.isRefreshing = true
            getnews()
        }
        binding.recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        binding.recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))       
        adapter = MyAdapter(ArrayList<MyData>())
        adapter.itemClickListener = object:MyAdapter.OnItemClickListener{
            override fun onItemClick(
                holder: MyAdapter.MyViewHolder,
                view: View,
                data: MyData,
                position: Int
            ) {
                val intent = Intent(ACTION_VIEW, Uri.parse(adapter.items[position].url))
                startActivity(intent)
            }
        }
        binding.recyclerView.adapter = adapter
        getnews()

    }

}