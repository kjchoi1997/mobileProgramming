package com.example.radiogroupprac

import android.os.Bundle
import android.widget.ImageView
import android.widget.RadioButton
import android.widget.RadioGroup
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        init()
    }

    fun init(){
        val radioGroup = findViewById<RadioGroup>(R.id.radioGroup)
        val radiobtn1 = findViewById<RadioButton>(R.id.radioButton)
        val radiobtn2 = findViewById<RadioButton>(R.id.radioButton2)
        val radiobtn3 = findViewById<RadioButton>(R.id.radioButton3)
        val imageView = findViewById<ImageView>(R.id.imageView)

        radioGroup.setOnCheckedChangeListener { group, checkedId ->
            when(checkedId){
                R.id.radioButton -> imageView.setImageResource(R.drawable.photo1)
                R.id.radioButton2 -> imageView.setImageResource(R.drawable.photo2)
                R.id.radioButton3 -> imageView.setImageResource(R.drawable.photo3)
            }
        }

    }
}