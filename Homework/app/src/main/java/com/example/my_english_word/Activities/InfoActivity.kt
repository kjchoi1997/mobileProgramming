package com.example.my_english_word.Activities

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.my_english_word.R
import com.example.my_english_word.databinding.ActivityInfoBinding

class InfoActivity : AppCompatActivity() {
    lateinit var binding:ActivityInfoBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityInfoBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    private fun init(){
        binding.apply{
            mailLinear.setOnClickListener {
                val to  = "greenjoa@gmail.com"
                val subject = "나만의 영어 단어장 문의사항 입니다."
                val message = "이곳에 문의사항을 입력해주세요"

                val intent = Intent(Intent.ACTION_SEND)
                val addressees = arrayOf(to)
                intent.putExtra(Intent.EXTRA_EMAIL, addressees)
                intent.putExtra(Intent.EXTRA_SUBJECT, subject)
                intent.putExtra(Intent.EXTRA_TEXT, message)
                intent.setType("message/rfc822")
                startActivity(Intent.createChooser(intent, "메일을 보낼 어플리케이션을 선택하세"))
            }

            locLinear.setOnClickListener {
                val location = Uri.parse("geo:37.543684, 127.077130?z=16")
                val mapIntent = Intent(Intent.ACTION_VIEW, location)
                startActivity(mapIntent)
            }
        }
    }
}
