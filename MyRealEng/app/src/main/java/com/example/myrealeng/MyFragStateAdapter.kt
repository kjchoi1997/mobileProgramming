package com.example.myrealeng

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.adapter.FragmentStateAdapter

class MyFragStateAdapter(fragmentActivity: FragmentActivity) :
    FragmentStateAdapter(fragmentActivity) {
    override fun getItemCount(): Int {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        return 3
    }

    override fun createFragment(position: Int): Fragment {
        //TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
        return when(position){
            0->QuizFragment()
            1->VocaFragment()
            2->NoteFragment()
            else->QuizFragment()
        }
    }
}