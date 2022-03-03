package com.example.myfragmentapp

import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.example.myfragmentapp.databinding.FragmentImageBinding


class ImageFragment : Fragment() {
    var binding:FragmentImageBinding?=null
    val myViewModel:MyViewModel by activityViewModels()
    val imglist = arrayListOf<Int>(R.drawable.one,R.drawable.two,R.drawable.three)
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentImageBinding.inflate(layoutInflater, container, false)
        return binding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding!!.apply {
            imageView.setOnClickListener{
                if(resources.configuration.orientation== Configuration.ORIENTATION_PORTRAIT){
                    val i = Intent(activity, SecondMainActivity::class.java)
                    i.putExtra("imgNum", myViewModel.selectednum.value)
                    startActivity(i)
                }
//                val fragment = requireActivity().supportFragmentManager.beginTransaction()
//                fragment.addToBackStack(null)
//                val textfragment = TextFragment()
//                fragment.replace(R.id.frameLayout, textfragment)
            }
            radioGroup.setOnCheckedChangeListener{group, checkedId->
                when(checkedId){
                    R.id.radioBtn1->{
                        myViewModel.setLiveData(0)
                    }
                    R.id.radioBtn2->{
                        myViewModel.setLiveData(1)
                    }
                    R.id.radioBtn3->{
                        myViewModel.setLiveData(2)
                    }
                }
                imageView.setImageResource(imglist[myViewModel.selectednum.value!!])
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        binding = null
    }


}