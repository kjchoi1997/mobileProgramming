package com.example.my_english_word.Activities

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.example.my_english_word.DB.MyDBHelper
import com.example.my_english_word.MyData
import com.example.my_english_word.R
import com.example.my_english_word.databinding.ActivityMainBinding
import java.util.*

class MainActivity : AppCompatActivity() {
    lateinit var binding:ActivityMainBinding
    lateinit var myDBHelper:MyDBHelper

    var data:ArrayList<MyData> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initDB()
        init()
    }

    private fun initDB(){
        myDBHelper = MyDBHelper(this)
        val dbfile = getDatabasePath("mydb.db")

        if(!dbfile.parentFile.exists()) dbfile.parentFile.mkdir()
        if(!dbfile.exists()){
            Log.i("TESTTEST", "dbfile not exist")
            val scan = Scanner(resources.openRawResource(R.raw.words))
            while(scan.hasNextLine()){
                val word = scan.nextLine()
                val meaning = scan.nextLine()
                val flag = myDBHelper.insertWord(MyData(0, word, meaning, 0, 0))
            }
        }
        else{
            Log.i("TESTTEST", "dbfile exist")
//            data = myDBHelper.getAllData()
//            Log.i("TESTTEST", data[0].word)
        }



    }

    private fun init(){
        binding.apply{
            vocaLinear.setOnClickListener {
                val intent = Intent(this@MainActivity, VocaActivity::class.java)
                startActivity(intent)
            }
            examLinear.setOnClickListener {
                val intent = Intent(this@MainActivity, ExamActivity::class.java)
                startActivity(intent)
            }
            addLinear.setOnClickListener {
                val intent = Intent(this@MainActivity, AddWordActivity::class.java)
                startActivity(intent)
            }
            infoLinear.setOnClickListener {
                val intent = Intent(this@MainActivity, InfoActivity::class.java)
                startActivity(intent)
            }
        }
    }

}
