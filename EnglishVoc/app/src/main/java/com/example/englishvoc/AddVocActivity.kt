package com.example.englishvoc

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import java.io.PrintStream

class AddVocActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_voc)
        init()
    }

    private fun init(){
        val addbtn = findViewById<Button>(R.id.button3)
        val cancelbtn = findViewById<Button>(R.id.button4)
        val editword = findViewById<EditText>(R.id.word)
        val editmeaning = findViewById<EditText>(R.id.meaning)

        addbtn.setOnClickListener {
            val word = editword.text.toString()
            val meaning = editmeaning.text.toString()
            writeFile(word, meaning)
        }
        cancelbtn.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }
    }

    private fun writeFile(word: String, meaning: String) {
        val show = false
        val output = PrintStream(openFileOutput("out.txt", MODE_APPEND))
        output.println(word)
        output.println(meaning)
        output.close()
        val intent = Intent()
        intent.putExtra("voc", MyData(word,meaning, show))
        setResult(Activity.RESULT_OK, intent)
        finish()
    }
}