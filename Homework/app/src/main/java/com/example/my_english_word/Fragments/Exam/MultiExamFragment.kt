package com.example.my_english_word.Fragments.Exam

import android.content.Context
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
import com.example.my_english_word.databinding.FragmentMultiExamBinding
import kotlinx.android.synthetic.main.fragment_multi_exam.*
import kotlinx.android.synthetic.main.fragment_multi_exam.view.*
import org.w3c.dom.Text
import java.util.*
import kotlin.collections.ArrayList


class MultiExamFragment(val count : Int) : Fragment() {
    lateinit var tts : TextToSpeech
    lateinit var myDBHelper : MyDBHelper

    var data :ArrayList<MyData> = ArrayList()
    var binding : FragmentMultiExamBinding ?= null
    var randNum:Int = 0
    var selected :Int = 0
    var isTtsReady = false
    var question:String ?= null
    var answer:String ?= null



    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentMultiExamBinding.inflate(layoutInflater, container, false)
        initTTS()
        init()
        return binding!!.root
    }

    private fun initTTS(){
        tts= TextToSpeech(activity, TextToSpeech.OnInitListener {
            isTtsReady = true
            tts.language = Locale.US
        })
    }

    private fun init(){
        setData()
        binding!!.apply{
            questionText.setOnClickListener {
                if(isTtsReady and (count == 2)) tts.speak(data[randNum].word, TextToSpeech.QUEUE_ADD, null, null)
            }

            answerBtnGroup.setOnCheckedChangeListener { group, checkedId ->
                when(checkedId){
                    R.id.answerBtn1 -> selected = 0
                    R.id.answerBtn2 -> selected = 1
                    R.id.answerBtn3 -> selected = 2
                    R.id.answerBtn4 -> selected = 3
                }
            }

            checkAnswerBtn.setOnClickListener {
                Toast.makeText(activity, answer, Toast.LENGTH_SHORT).show()
            }

            submitBtn.setOnClickListener {
                if(randNum == selected){
                    Toast.makeText(activity, "정답입니다!!", Toast.LENGTH_SHORT).show()
                    setData()
                }
                else{
                    Toast.makeText(activity, "오답입니다!!", Toast.LENGTH_SHORT).show()
                    val tmpWord = MyData(data[randNum].pid, data[randNum].word, data[randNum].meaning, data[randNum].favorite, 1)
                    myDBHelper.updateWord(tmpWord)
                }
            }

            nextQuestionBtn.setOnClickListener {
                setData()
            }
        }
    }

    private fun setData(){
        randNum = (0..3).random()
        data = myDBHelper.getRandomData(4)

        if(count == 1){
            question = data[randNum].word
            answer = data[randNum].meaning
            binding!!.answerBtn1.text = data[0].meaning
            binding!!.answerBtn2.text = data[1].meaning
            binding!!.answerBtn3.text = data[2].meaning
            binding!!.answerBtn4.text = data[3].meaning
        }
        else if(count == 2){
            question = "듣기"
            answer = data[randNum].word
            binding!!.answerBtn1.text = data[0].word
            binding!!.answerBtn2.text = data[1].word
            binding!!.answerBtn3.text = data[2].word
            binding!!.answerBtn4.text = data[3].word
        }
        binding!!.questionText.text = question


    }

    override fun onDestroy() {
        super.onDestroy()
        binding = null
        tts.shutdown()
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
