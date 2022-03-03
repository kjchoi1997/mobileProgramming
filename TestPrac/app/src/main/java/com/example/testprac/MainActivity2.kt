package com.example.testprac

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.example.testprac.databinding.ActivityMain2Binding

class MainActivity2 : AppCompatActivity() {
    lateinit var binding: ActivityMain2Binding
    val CALL_REQUEST = 100
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMain2Binding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)
        init()
    }
    fun callAlertDlg(){
        val builder = AlertDialog.Builder(this)
        builder.setMessage("반드시 CALL_PHONE 권한이 허용되어야 합니다.")
            .setTitle("권한허용")
            .setPositiveButton("OK"){
                _,_->ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.CALL_PHONE), CALL_REQUEST)
            }
        val dlg = builder.create()
        dlg.show()
    }

    private fun init() {
        with(binding){
            callBtn.setOnClickListener {
                callAction()
            }
        }
    }

    private fun callAction() {
        val number = Uri.parse("tel:010-2426-6038");
        val callIntent = Intent(Intent.ACTION_CALL, number);
        if(ActivityCompat.checkSelfPermission(this,android.Manifest.permission.CALL_PHONE)!= PackageManager.PERMISSION_GRANTED) {
            callAlertDlg()
        }
        else {
            startActivity(callIntent)
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when(requestCode){
            CALL_REQUEST->{
                if(grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(this, "권한이 승인되었습니다.", Toast.LENGTH_SHORT).show()
                    callAction()
                }
                else{
                    Toast.makeText(this, "권한이 거부되었습니다.", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}