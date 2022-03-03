package com.example.englishvoc

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.englishvoc.databinding.ActivityVocBinding
import com.google.android.material.tabs.TabLayoutMediator

class VocActivity : AppCompatActivity() {
    lateinit var binding:ActivityVocBinding
        val textarr = arrayListOf<String>("단어장", "웹 검색" )
        val iconarr = arrayListOf<Int>(R.drawable.ic_baseline_list_24,R.drawable.ic_baseline_search_24)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityVocBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }
    private fun init(){
        binding.viewpager.adapter = MyFragStateAdapter(this)
        TabLayoutMediator(binding.tablayout, binding.viewpager){
                tab, position->
            tab.text = textarr[position]
            tab.setIcon(iconarr[position])
        }.attach()
    }
}