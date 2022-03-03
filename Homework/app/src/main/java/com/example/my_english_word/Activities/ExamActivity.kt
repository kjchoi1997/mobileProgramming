package com.example.my_english_word.Activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.speech.tts.TextToSpeech
import com.example.my_english_word.Adapter.MyExamFragStateAdapter
import com.example.my_english_word.R
import com.example.my_english_word.databinding.ActivityExamBinding
import com.google.android.material.tabs.TabLayoutMediator
import java.util.*

class ExamActivity : AppCompatActivity() {
    lateinit var binding :ActivityExamBinding

    val textArr = arrayListOf<String>("객관식시험", "단답식시험", "오답 시험", "듣기 평가", "받아 쓰기")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityExamBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init(){
        binding.examViewPager.adapter = MyExamFragStateAdapter(this)
        TabLayoutMediator(binding.examTabLayout, binding.examViewPager){
            tab, position->
            tab.text = textArr[position]
        }.attach()
    }
}
