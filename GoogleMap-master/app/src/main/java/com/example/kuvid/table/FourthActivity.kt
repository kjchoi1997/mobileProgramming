package com.example.kuvid19

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.example.kuvid.R
import kotlinx.android.synthetic.main.activity_fourth.*
import kotlinx.android.synthetic.main.activity_main.*


public class FourthActivity : AppCompatActivity() {
    lateinit var context : Context

    @SuppressLint("ResourceAsColor", "NewApi", "WrongConstant")
    @RequiresApi(Build.VERSION_CODES.N)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fourth)

        // 프래그먼트 달기
        val adapter = MainAdapter(supportFragmentManager)
        adapter.addFragment(MainFragment(), "지역")
        adapter.addFragment(SecondFragment(), "연령")
        adapter.addFragment(ThirdFragment(), "성별")
        adapter.addFragment(ChartAgeFragment(), "연령\n차트")
        adapter.addFragment(ChartSexFragment(), "성별\n차트")
        adapter.addFragment(ChartWeekFragment(), "주간\n차트")

        viewPaper.adapter = adapter
        viewPaperTabLayout.setupWithViewPager(viewPaper)
    }
}