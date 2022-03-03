package com.example.coronaapp

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.coronaapp.databinding.FragmentNewsBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jsoup.Jsoup


class NewsFragment : Fragment() {

    var binding: FragmentNewsBinding?=null
    lateinit var adapter: MyAdapter
    //url
    val url = "https://search.daum.net/search?nil_suggest=sugsch&w=news&DA=GIQ&sq=%EC%BD%94%EB%A1%9C%EB%82%98&o=4&sugo=15&cluster=y&q=%EC%BD%94%EB%A1%9C%EB%82%98+19"
    val scope = CoroutineScope(Dispatchers.IO)
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        binding = FragmentNewsBinding.inflate(layoutInflater, container, false)
        return binding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        init()
    }

    private fun init() {
        binding!!.apply {
            swipe.setOnRefreshListener {
                swipe.isRefreshing = true
                getnews()
            }
            recyclerView.layoutManager =
                LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false)
            recyclerView.addItemDecoration(
                DividerItemDecoration(
                    getActivity(),
                    LinearLayoutManager.VERTICAL
                )
            )
            adapter = MyAdapter(ArrayList<MyData>())
            adapter.itemClickListener = object : MyAdapter.OnItemClickListener {
                override fun onItemClick(
                    holder: MyAdapter.MyViewHolder,
                    view: View,
                    data: MyData,
                    position: Int
                ) {
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(adapter.items[position].url))
                    startActivity(intent)
                }
            }
            recyclerView.adapter = adapter
            getnews()
        }
    }

    private fun getnews() {
        scope.launch {
            binding!!.apply {

                adapter.items.clear()
                val doc = Jsoup.connect(url).get()
                val headlines = doc.select("li>div>div>div>a")
                for (news in headlines) {
                    adapter.items.add(MyData(news.text(), news.absUrl("href")))
                }
                withContext(Dispatchers.Main) {
                    adapter.notifyDataSetChanged()
                    swipe.isRefreshing = false
                }
            }
        }
    }

}