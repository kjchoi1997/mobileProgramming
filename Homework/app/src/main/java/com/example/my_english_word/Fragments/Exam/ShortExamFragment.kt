package com.example.my_english_word.Fragments.Exam

import android.content.Context
import android.graphics.Color
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.example.my_english_word.DB.MyDBHelper
import com.example.my_english_word.MyData

import com.example.my_english_word.R
import com.example.my_english_word.databinding.FragmentShortExamBinding
import java.util.*
import kotlin.collections.ArrayList


class ShortExamFragment(val count:Int) : Fragment() {
    lateinit var tts : TextToSpeech
    lateinit var myDBHelper : MyDBHelper

    var data :ArrayList<MyData> = ArrayList()
    var question : String ?= null
    var answer : String ?= null
    var binding:FragmentShortExamBinding?=null
    var isTtsReady = false

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentShortExamBinding.inflate(layoutInflater, container, false)
        initTTS()
        init()
        return binding!!.root
    }

    private fun init(){
        setData()
        binding!!.apply{
            questionText.setOnClickListener {
                if(isTtsReady and !data.isEmpty() and (count == 3)) tts.speak(data[0].word, TextToSpeech.QUEUE_ADD, null, null)
            }

            checkAnswerBtn.setOnClickListener {
                if(!data.isEmpty()) Toast.makeText(activity, answer, Toast.LENGTH_SHORT).show()
            }

            submitBtn.setOnClickListener {
                val userMeaning = binding!!.answerEdit.text.toString()

                if(!data.isEmpty()){
                    if(userMeaning == answer){
                        Toast.makeText(activity, "정답입니다!!", Toast.LENGTH_SHORT).show()
                        binding!!.imageView.setImageResource(R.drawable.ic_done_black_24dp)
                        binding!!.imageView.setColorFilter(Color.parseColor("#FF38F440"))
                        val tmpWord = MyData(data[0].pid, data[0].word, data[0].meaning, data[0].favorite, 0)
                        myDBHelper.updateWord(tmpWord)
                        setData()
                    }
                    else{
                        Toast.makeText(activity, "오답입니다!!", Toast.LENGTH_SHORT).show()
                        binding!!.imageView.setImageResource(R.drawable.ic_error_outline_black_24dp)
                        binding!!.imageView.setColorFilter(Color.parseColor("#FFEF1E1E"))
                        val tmpWord = MyData(data[0].pid, data[0].word, data[0].meaning, data[0].favorite, 1)
                        binding!!.answerEdit.text = null
                        myDBHelper.updateWord(tmpWord)
                    }
                }

            }

            nextQuestionBtn.setOnClickListener {
                setData()
            }
        }
    }

    private fun setData(){
        if(count == 1) {
            data = myDBHelper.getRandomData(1)
            question = data[0].word
            answer = data[0].meaning
        }
        if(count == 2) {
            data = myDBHelper.getRandomWrongData(1)
            if(data.isEmpty()) {
                question = "오답이 없습니다!!"
            }
            else{
                question = data[0].word
                answer = data[0].meaning
            }
        }
        if(count == 3){
            data = myDBHelper.getRandomData(1)
            question = "듣기"
            answer = data[0].word
        }
        binding!!.questionText.text = question
        binding!!.answerEdit.text = null
    }

    override fun onDestroy() {
        super.onDestroy()
        binding = null
        tts.shutdown()
    }

    private fun initTTS(){
        tts = TextToSpeech(activity, TextToSpeech.OnInitListener {
            isTtsReady = true
            tts.language = Locale.US
        })
    }

    override fun onStop() {
        super.onStop()
        tts.stop()
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        myDBHelper = MyDBHelper(context)
    }
}
