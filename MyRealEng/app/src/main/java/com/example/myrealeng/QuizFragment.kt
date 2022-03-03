package com.example.myrealeng

import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.fragment_quiz.*
import kotlinx.android.synthetic.main.fragment_voca.*
import java.io.File
import java.io.PrintStream
import java.util.*
import kotlin.collections.ArrayList

/**
 * A simple [Fragment] subclass.
 */
class QuizFragment : Fragment() {

    var words = mutableMapOf<String, String>()//단어와 뜻을 모두 포함
    var array = ArrayList<String>()//뜻만 포함
    lateinit var adapter: QuizAdapter
    var score = 0

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_quiz, container, false)
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        init()
    }

    private fun init() {
        readfile()
        quizrecycler.layoutManager=LinearLayoutManager(activity, LinearLayoutManager.VERTICAL, false)
        var arrayquiz = ArrayList<String>()
        makequiz(arrayquiz)
        adapter = QuizAdapter(arrayquiz)
        var answer = (0..4).random()//5개중에 하나 정답으로 뽑기
        quizword.text = words[arrayquiz[answer]]//뽑은 뜻에 해당하는 영단어 저장
        adapter.itemClickListener = object : QuizAdapter.OnItemClickListener {
            override fun OnItemClick(
                holder: QuizAdapter.MyViewHolder,
                view: View,
                data: String,
                position: Int
            ) {
                if (arrayquiz[answer] == data) {
                    score += 10
                    Toast.makeText(activity!!, "정답입니다. 점수는" + score.toString() + "점입니다.", Toast.LENGTH_SHORT).show()
                } else {
                    Toast.makeText(activity!!, "오답입니다. 점수는" + score.toString() + "점입니다.", Toast.LENGTH_SHORT).show() //배열 초기화
                    writefile(words[arrayquiz[answer]].toString(), arrayquiz[answer])
                }
                makequiz(arrayquiz)
                adapter.notifyDataSetChanged()
                answer = (0..4).random()//새로하나또뽑기
                quizword.text = words[arrayquiz[answer]]//새로뽑은뜻의 영단어 저장
            }
        }
        quizrecycler.adapter = adapter
        backbtn.setOnClickListener {
            activity!!.setResult(Activity.RESULT_CANCELED)
            activity!!.finish()
        }
    }


    fun readfile() {
        val scan2 = Scanner(requireActivity().openFileInput("out.txt"))
        readfilescan(scan2)
        
         val scan = Scanner(resources.openRawResource(R.raw.words))//파일을 읽어오는 스캐너 객체
         readfilescan(scan)
    }

    fun readfilescan(scan: Scanner){
        while (scan.hasNextLine()) {
            val word = scan.nextLine()
            val meaning = scan.nextLine()
            words[meaning] = word
            array.add(meaning)
        }
        scan.close()
    }

    fun makequiz(items: ArrayList<String>) {
        items.clear()
        var ran = arrayOfNulls<Int>(5)
        var i = 0
        while (i < 5) {
            var rannum = (0..array.size - 1).random()
            if (rannum in ran)
                continue
            else {
                items.add(array[rannum])
                ran[i++] = rannum
            }
        }
    }

    fun writefile(word: String, meaning: String){
        val output=PrintStream(requireActivity().openFileOutput("note.txt", Context.MODE_APPEND))
        output.println(word)
        output.println(meaning)
        output.close()
    }

}
