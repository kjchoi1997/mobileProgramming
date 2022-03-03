package com.example.my_english_word.Activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.core.widget.addTextChangedListener
import com.example.my_english_word.DB.MyDBHelper
import com.example.my_english_word.MyData
import com.example.my_english_word.R
import com.example.my_english_word.databinding.ActivityAddWordBinding

class AddWordActivity : AppCompatActivity() {
    lateinit var binding:ActivityAddWordBinding
    lateinit var myDBHelper : MyDBHelper

    var wordExist :Boolean = false
    var meanExist :Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddWordBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }
    private fun init(){
        myDBHelper = MyDBHelper(this)

        binding.apply{
            wordEdit.addTextChangedListener {
                val str = it.toString()
                wordExist = str.isNotEmpty()
                if(wordExist and meanExist) addWordBtn.isEnabled = true
                else addWordBtn.isEnabled = false
            }
            meanEdit.addTextChangedListener {
                val str = it.toString()
                meanExist = str.isNotEmpty()
                if(wordExist and meanExist) addWordBtn.isEnabled = true
                else addWordBtn.isEnabled = false
            }
            addWordBtn.setOnClickListener {
                val word = wordEdit.text.toString()
                val mean = meanEdit.text.toString()
                val flag = myDBHelper.insertWord(MyData(0, word, mean, 0, 0))
                if(flag) Toast.makeText(this@AddWordActivity, "단어가 추가되었습니다!!", Toast.LENGTH_SHORT).show()
                else Toast.makeText(this@AddWordActivity, "단어 추가에 실패했습니다..", Toast.LENGTH_SHORT).show()
                wordEdit.text = null
                meanEdit.text = null
            }
        }
    }
}
