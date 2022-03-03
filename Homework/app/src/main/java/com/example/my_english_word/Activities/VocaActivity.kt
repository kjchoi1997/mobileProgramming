package com.example.my_english_word.Activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.my_english_word.Adapter.MyVocaFragStateAdapter
import com.example.my_english_word.databinding.ActivityVocaBinding
import com.google.android.material.tabs.TabLayoutMediator

class VocaActivity : AppCompatActivity() {
    lateinit var binding:ActivityVocaBinding
    val textArr = arrayListOf<String>("단어장", "즐겨찾기", "오답", "웹 검색")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityVocaBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }
    private fun init(){
        binding.wordViewPager.adapter =
            MyVocaFragStateAdapter(this)
        TabLayoutMediator(binding.wordTabLayout, binding.wordViewPager){
            tab, position->
            tab.text = textArr[position]
        }.attach()
    }
}
