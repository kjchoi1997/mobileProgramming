package com.example.myrealeng

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_add_voc.*
import java.io.PrintStream

class AddVocActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_voc)
        init()
    }

    private fun init() {
        add.setOnClickListener {
            val word=word.text.toString()
            val meaning=meaning.text.toString()
            writefile(word, meaning)
        }
        cancel.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }
    }

    private fun writefile(word: String, meaning: String) {//파일추가
        val output= PrintStream(openFileOutput("out.txt", Context.MODE_APPEND))
        output.println(word)
        output.println(meaning)
        output.close()
        val i= Intent()
        i.putExtra("voc", MyData(word, meaning))
        setResult(Activity.RESULT_OK, i)
        finish()
    }
}
