package com.example.a201712099

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class kjchoiMainActivity2 : AppCompatActivity() {
    var sum = 0;
    val ADD_LIST = 100
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.kjchoiactivity_main2)
        init()
    }

    private fun init() {
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when(requestCode){
            ADD_LIST->{
                if(resultCode == Activity.RESULT_OK){
                    val str = data?.getSerializableExtra("voc", ) as kjchoiMyData
                    val priceText = findViewById<TextView>(R.id.totalpricetext)
                    sum += str.price.toInt()
                    priceText.setText(sum.toString() + "원")
                }
            }
        }
    }


}