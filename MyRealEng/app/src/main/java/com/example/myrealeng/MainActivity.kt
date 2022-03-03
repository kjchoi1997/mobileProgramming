package com.example.myrealeng

import android.content.res.Configuration
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.google.android.material.tabs.TabLayoutMediator
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    val textArray= arrayListOf<String>("퀴즈", "단어리스트", "오답노트")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        if(resources.configuration.orientation==Configuration.ORIENTATION_PORTRAIT)
            init()
    }

    private fun init() {
        viewPager.adapter=MyFragStateAdapter(this)
        TabLayoutMediator(tabLayout, viewPager){
            tab, postion->
            tab.text=textArray[postion]
            //아이콘이미지추가하기
        }.attach()

    }
}
