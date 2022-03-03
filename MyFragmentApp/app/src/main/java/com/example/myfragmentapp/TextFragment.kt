package com.example.myfragmentapp

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import com.example.myfragmentapp.databinding.FragmentTextBinding

class TextFragment : Fragment() {

    var binding: FragmentTextBinding?=null
    val myViewModel:MyViewModel by activityViewModels()
    val data = arrayListOf<String>("ImageData1 201712099 최규진","ImageData2 201712099 최규진","ImageData3 201712099 최규진")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentTextBinding.inflate(layoutInflater, container, false)
        return binding!!.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        binding = null
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val intent = requireActivity().intent
        val imgNum = intent.getIntExtra("imgNum", -1)
        if(imgNum != -1){
            binding!!.textView.text = data[imgNum]
        }
        else {
            myViewModel.selectednum.observe(viewLifecycleOwner, Observer {
                binding!!.textView.text = data[it]
            })
        }
    }

}