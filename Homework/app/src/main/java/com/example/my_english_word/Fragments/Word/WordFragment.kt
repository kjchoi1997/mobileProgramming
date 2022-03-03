package com.example.my_english_word.Fragments.Word

import android.content.Context
import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.example.my_english_word.DB.MyDBHelper
import com.example.my_english_word.MyData
import com.example.my_english_word.Adapter.MyWordRecyclerViewAdapter
import com.example.my_english_word.R
import java.util.*

import kotlin.collections.ArrayList

class WordFragment(val count :Int) : Fragment() {
    lateinit var myDBHelper : MyDBHelper
    lateinit var tts : TextToSpeech

    var favoriteData:ArrayList<MyData> = ArrayList()
    var wrongData:ArrayList<MyData> = ArrayList()
    var isTtsReady = false

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        initTTS()
        initFavoriteData()
        val view = inflater.inflate(R.layout.fragment_word_list, container, false)

        if (view is RecyclerView) {
            view.layoutManager = LinearLayoutManager(context)
            view.adapter = when(count){
                1-> makeAdapter(favoriteData)
                2-> makeAdapter(wrongData)
                else -> makeAdapter(favoriteData)
            }
        }
        return view
    }

    override fun onResume() {
        super.onResume()
        val recyclerView = getView()!!.findViewById<RecyclerView>(R.id.list2)
        recyclerView.adapter = when(count){
            1-> {
                initFavoriteData()
                makeAdapter(favoriteData)
            }
            2->{
                initWrongData()
                makeAdapter(wrongData)
            }
            else->{
                initFavoriteData()
                makeAdapter(favoriteData)
            }
        }
    }

    private fun makeAdapter(dataList:List<MyData>) : MyWordRecyclerViewAdapter {
        val tmpAdapter = MyWordRecyclerViewAdapter(dataList)

        tmpAdapter.clickWordListner = object:
            MyWordRecyclerViewAdapter.OnClickWordListner{
            override fun onClickFavor(data: MyData) {
                val tmpData = MyData(data.pid, data.word, data.meaning, Math.abs(data.favorite - 1), data.wrong)
                myDBHelper.updateWord(tmpData)
            }
            override fun onClickWord(data: MyData) {
                Toast.makeText(activity, data.meaning, Toast.LENGTH_SHORT).show()
                if(isTtsReady) tts.speak(data.word, TextToSpeech.QUEUE_ADD, null, null)
            }
        }
        return tmpAdapter
    }

    private fun initTTS(){
        tts = TextToSpeech(activity, TextToSpeech.OnInitListener {
            isTtsReady = true
            tts.language = Locale.US
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        tts.shutdown()
    }

    override fun onStop() {
        super.onStop()
        tts.stop()
    }

    private fun initFavoriteData(){
        favoriteData.clear()
        favoriteData = myDBHelper.getFavoriteData()
    }

    private fun initWrongData(){
        wrongData.clear()
        wrongData = myDBHelper.getWrongData()
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        myDBHelper = MyDBHelper(context)
    }
}
