package com.example.englishvoc

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.englishvoc.databinding.ActivityMainBinding
import java.util.*

@Suppress("DEPRECATION")
class MainActivity : AppCompatActivity() {
    val ADD_VOC_REQUEST = 100
    lateinit var binding: ActivityMainBinding

    var data: ArrayList<MyData> = ArrayList()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init(){
        binding.apply{
            menu1.setOnClickListener{
                val intent= Intent(this@MainActivity, AddVocActivity::class.java)
                startActivityForResult(intent,ADD_VOC_REQUEST)
            }
            menu2.setOnClickListener{
                val intent = Intent(this@MainActivity, VocActivity::class.java)
                startActivity(intent)

            }
            menu3.setOnClickListener{
                val intent = Intent(this@MainActivity, TestActivity::class.java)
                startActivity(intent)
            }
            menu4.setOnClickListener{
                moveTaskToBack(true)
                finishAndRemoveTask()
                android.os.Process.killProcess(android.os.Process.myPid())

            }
        }
    }

    @Override
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        setContentView(R.layout.activity_main)

    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when(requestCode) {
            ADD_VOC_REQUEST -> {
                if (resultCode == Activity.RESULT_OK) {
                    val str = data?.getSerializableExtra("voc")as MyData
                    Toast.makeText(this, str.word+"단어 추가 됨", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}