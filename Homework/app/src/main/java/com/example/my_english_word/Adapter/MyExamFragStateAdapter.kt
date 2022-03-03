package com.example.my_english_word.Adapter

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.example.my_english_word.Fragments.Exam.MultiExamFragment
import com.example.my_english_word.Fragments.Exam.ShortExamFragment

class MyExamFragStateAdapter(fragmentActivity: FragmentActivity) :
    FragmentStateAdapter(fragmentActivity) {
    override fun getItemCount(): Int {
        return 5
    }

    override fun createFragment(position: Int): Fragment {
        return when(position){
            0-> MultiExamFragment(1)
            1-> ShortExamFragment(1)
            2-> ShortExamFragment(2)
            3-> MultiExamFragment(2)
            4-> ShortExamFragment(3)
            else-> MultiExamFragment(1)
        }
    }
}