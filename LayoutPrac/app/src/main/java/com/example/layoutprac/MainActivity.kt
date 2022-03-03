package com.example.layoutprac

import android.os.Bundle
import android.view.View
import android.widget.CheckBox
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    var checkid = intArrayOf(R.id.checkBox1,R.id.checkBox2,R.id.checkBox3,R.id.checkBox4,R.id.checkBox5,R.id.checkBox6,R.id.checkBox7,R.id.checkBox8,R.id.checkBox9,R.id.checkBox10)
    var imageid = intArrayOf(R.id.hat,R.id.arms,R.id.body,R.id.ears,R.id.eyebrows,R.id.eyes,R.id.glasses,R.id.mouth,R.id.mustache)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        init()
    }

    fun init(){
        for(id in checkid){
            val checkBox = findViewById<CheckBox>(id)
            checkBox.setOnCheckedChangeListener { buttonView, isChecked ->
                for(newid in imageid){
                    val imageView = findViewById<ImageView>(newid)
                    if(isChecked){
                        imageView.visibility = View.VISIBLE
                    }
                    else{
                        imageView.visibility = View.INVISIBLE
                    }
                }
            }
        }
    }


}