package com.example.kuvid.news

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.kuvid.databinding.FragmentWebBinding

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
            binding!!.WebView.loadUrl("https://m.search.naver.com/search.naver?sm=mtb_hty.top&where=m&oquery=%EC%BD%94%EB%A1%9C%EB%82%98+%EB%89%B4%EC%8A%A4&tqi=hKfc%2Fdprv2NssslwbjGssssssU8-389085&query=%EC%BD%94%EB%A1%9C%EB%82%9819")
    }

    override fun onDestroy() {
        super.onDestroy()
        binding = null
    }
}