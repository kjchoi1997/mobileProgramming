package com.example.togglebutton

import android.os.Bundle
import android.widget.Toast
import android.widget.ToggleButton
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        init()
    }
    fun init(){
        val toggleBtn = findViewById<ToggleButton>(R.id.toggleButton)
        toggleBtn.setOnCheckedChangeListener { buttonView, isChecked ->
            if(isChecked)
                Toast.makeText(this, "Toggle On", Toast.LENGTH_SHORT).show()
            else
                Toast.makeText(this, "Toggle Off", Toast.LENGTH_SHORT).show()
        }
    }
}