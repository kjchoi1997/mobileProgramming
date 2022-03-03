package com.example.myfragmentapp

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import com.example.myfragmentapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    lateinit var binding: ActivityMainBinding
    val myViewModel:MyViewModel by viewModels()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }
//    fun init(){
//        val fragment = supportFragmentManager.beginTransaction()
//        val imgFragment = ImageFragment()
//        fragment.replace(R.id.frameLayout, imgFragment)
//        fragment.commit()
//    }
}