package com.example.englishvoc

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.englishvoc.databinding.FragmentQuizBinding
import java.io.PrintStream
import java.util.*
import kotlin.collections.ArrayList


class QuizFragment : Fragment() {
    var flag: Int = 0
    var rightflag: Int = 0
    var binding : FragmentQuizBinding? = null
    var score = 0

    var worddata = mutableMapOf<String, String>()
    var meaningarr = ArrayList<String>()
    lateinit var adapter: QuizAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentQuizBinding.inflate(layoutInflater, container, false)
        init()
        return binding!!.root
    }


    private fun init() {
        readfile()
        binding!!.apply {
            quizrecycler.layoutManager = LinearLayoutManager(activity, LinearLayoutManager.VERTICAL, false)
            var arrayquiz = ArrayList<String>()
            makequiz(arrayquiz)
            adapter = QuizAdapter(arrayquiz)
            var answer = (0..4).random()
            quizword.text = worddata[arrayquiz[answer]]
            adapter.itemClickListener = object : QuizAdapter.OnItemClickListener {
                override fun OnItemClick(
                    holder: QuizAdapter.MyViewHolder,
                    view: View,
                    data: String,
                    position: Int
                ) {
                    if (arrayquiz[answer] == data) {
                        score += 10
                        Toast.makeText(activity!!, "정답입니다.", Toast.LENGTH_SHORT).show()
                        rightflag++
                        flag++
                    }
                    else {
                        Toast.makeText(activity!!, "오답입니다.", Toast.LENGTH_SHORT).show()
                        flag++
                        writefile(worddata[arrayquiz[answer]].toString(), arrayquiz[answer])
                    }
                    if(flag == 10){
                        Toast.makeText(activity!!, "10문제 중 " + rightflag.toString() + "개를 맞췄고, 점수는" + score.toString() + "점입니다.", Toast.LENGTH_SHORT).show()
                        flag = 0
                    }
                    makequiz(arrayquiz)
                    adapter.notifyDataSetChanged()
                    answer = (0..4).random()
                    quizword.text = worddata[arrayquiz[answer]]
                }
            }
            quizrecycler.adapter = adapter
        }
    }


    fun readfile() {
        val scan2 = Scanner(requireActivity().openFileInput("out.txt"))
        readfilescan(scan2)
        val scan = Scanner(resources.openRawResource(R.raw.words))
        readfilescan(scan)
    }

    fun writefile(word: String, meaning: String){
        val output=PrintStream(requireActivity().openFileOutput("note.txt", Context.MODE_APPEND))
        output.println(word)
        output.println(meaning)
        output.close()
    }

    fun readfilescan(scan: Scanner){
        while (scan.hasNextLine()) {
            val word = scan.nextLine()
            val meaning = scan.nextLine()
            worddata[meaning] = word
            meaningarr.add(meaning)
        }
        scan.close()
    }

    fun makequiz(items: ArrayList<String>) {
        items.clear()
        var random = arrayOfNulls<Int>(5)
        var i = 0
        while (i < 5) {
            var randNum = (0..meaningarr.size - 1).random()
            if (randNum in random)
                continue
            else {
                items.add(meaningarr[randNum])
                random[i++] = randNum
            }
        }
    }


}
