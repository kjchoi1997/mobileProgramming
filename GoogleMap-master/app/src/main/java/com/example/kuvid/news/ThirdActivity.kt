package com.example.kuvid.news

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.kuvid.databinding.ActivityThirdBinding
import com.google.android.material.tabs.TabLayoutMediator

class ThirdActivity : AppCompatActivity() {
    lateinit var binding: ActivityThirdBinding
    val textarr  = arrayListOf<String>("코로나 뉴스 리스트", "코로나 웹 검색")


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityThirdBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init() {
        binding.viewpager.adapter = MyFragStateAdapter(this)
        TabLayoutMediator(binding.tablayout, binding.viewpager){
                tab, position->
            tab.text = textarr[position]
        }.attach()
    }
}