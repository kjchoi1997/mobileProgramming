package com.example.myrealeng

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_intro.*

class IntroActivity : AppCompatActivity() {

    val ADDVOC_REQUEST=100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_intro)
        init()
    }

    private fun init() {
        quizbtn.setOnClickListener {
            val i= Intent(this, MainActivity::class.java)//메인엑티비티로 넘어가는 클래스 하나 생성
            startActivity(i)
        }
        addvocbtn.setOnClickListener {
            val i= Intent(this, AddVocActivity::class.java)
            startActivityForResult(i, ADDVOC_REQUEST)//intent를 통해 메시지 전달
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when(requestCode) {
            ADDVOC_REQUEST -> {
                if (resultCode == Activity.RESULT_OK) {
                    val str = data?.getSerializableExtra("voc")as MyData
                    Toast.makeText(this, str.word+"단어 추가 됨", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}
