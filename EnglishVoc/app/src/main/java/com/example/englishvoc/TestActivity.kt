package com.example.englishvoc

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.englishvoc.databinding.ActivityTestBinding
import com.google.android.material.tabs.TabLayoutMediator

class TestActivity : AppCompatActivity() {
    lateinit var binding : ActivityTestBinding
    val textarr = arrayListOf<String>("객관식 테스트", "오답노트")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTestBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init(){
        binding.testviewpager.adapter = TestFragStateAdapter(this)
        TabLayoutMediator(binding.testtablayout, binding.testviewpager){
                tab, position->
            tab.text = textarr[position]
        }.attach()
    }
}