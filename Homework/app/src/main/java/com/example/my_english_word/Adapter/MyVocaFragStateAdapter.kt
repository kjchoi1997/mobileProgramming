package com.example.my_english_word.Adapter

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.example.my_english_word.Fragments.Word.SearchFragment
import com.example.my_english_word.Fragments.Word.AllWordFragment
import com.example.my_english_word.Fragments.Word.WordFragment

class MyVocaFragStateAdapter(fragmentActivity: FragmentActivity) :
    FragmentStateAdapter(fragmentActivity) {

    override fun getItemCount(): Int {
        return 4
    }

    override fun createFragment(position: Int): Fragment {
        return when(position){
            0-> AllWordFragment()
            1-> WordFragment(1)
            2-> WordFragment(2)
            3-> SearchFragment()
            else -> AllWordFragment()
        }
    }
}