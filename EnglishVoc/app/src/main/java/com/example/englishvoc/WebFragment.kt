package com.example.englishvoc

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.englishvoc.databinding.FragmentWebBinding

class WebFragment : Fragment() {

    var binding: FragmentWebBinding?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        binding = FragmentWebBinding.inflate(layoutInflater, container, false)
        return binding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding!!.searchBtn.setOnClickListener {
            val searchWord = binding!!.search.text.toString()
            binding!!.WebView.loadUrl("https://m.search.naver.com/search.naver?where=m_ldic&sm=mtb_jum&query=$searchWord")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        binding = null
    }
}