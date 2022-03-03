package com.example.testprac

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.RecyclerView

class IntroActivity : AppCompatActivity() {

    val ADD_LIST = 100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_intro)
        init()
    }

    private fun init() {
        val btn1 = findViewById<Button>(R.id.button)
        val btn2 = findViewById<Button>(R.id.button2)
        btn1.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)
            startActivityForResult(intent, ADD_LIST)
        }


        btn2.setOnClickListener {
            val intent = Intent(this, MainActivity2::class.java)
            startActivity(intent)
        }
    }
    var sum = 0

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when(requestCode){
            ADD_LIST->{
                if(resultCode == Activity.RESULT_OK){
                    val str = data?.getSerializableExtra("voc", ) as MyData
                    val priceText = findViewById<TextView>(R.id.totalpricetext)
                    sum += str.price.toInt()
                    priceText.setText(sum.toString() + "원")
                    val recyclerView = findViewById<RecyclerView>(R.id.introrecyclerView)
                }
            }
        }
    }

}