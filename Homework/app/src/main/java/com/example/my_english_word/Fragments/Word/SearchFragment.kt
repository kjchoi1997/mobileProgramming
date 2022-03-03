package com.example.my_english_word.Fragments.Word

import android.app.Activity
import android.content.ContentValues
import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import com.example.my_english_word.MyData

import com.example.my_english_word.R
import com.example.my_english_word.databinding.FragmentSearchBinding
import kotlinx.android.synthetic.main.fragment_search.view.*


class SearchFragment : Fragment() {
    var binding:FragmentSearchBinding ?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentSearchBinding.inflate(layoutInflater, container, false)
        return binding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding!!.searchBtn.setOnClickListener {
            val searchWord = binding!!.searchEditText.text.toString()
            binding!!.searchWebView.loadUrl("https://m.search.naver.com/search.naver?query=$searchWord&where=m_ldic&sm=msv_hty")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        binding = null
    }
}
