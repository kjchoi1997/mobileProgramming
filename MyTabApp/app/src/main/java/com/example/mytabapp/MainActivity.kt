package com.example.mytabapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.mytabapp.databinding.ActivityMainBinding
import com.google.android.material.tabs.TabLayoutMediator

class MainActivity : AppCompatActivity() {
    lateinit var binding:ActivityMainBinding
    val textarr = arrayListOf<String>("이미지", "리스트")
    val iconarr = arrayListOf<Int>(R.drawable.ic_baseline_image_24, R.drawable.ic_baseline_local_cafe_24)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
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