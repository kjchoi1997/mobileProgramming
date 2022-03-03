package com.example.a201712099

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.example.a201712099.databinding.KjchoiactivityIntroBinding

class kjchoiIntroActivity : AppCompatActivity() {
    lateinit var binding: KjchoiactivityIntroBinding
    val CALL_REQUEST = 100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = KjchoiactivityIntroBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)
        init()
    }

    private fun init() {
        with(binding){
            callBtn.setOnClickListener {
                callAction()
            }
        }
        val btn1 = findViewById<Button>(R.id.button)
        val btn2 = findViewById<Button>(R.id.button2)
        btn1.setOnClickListener {
            val intent = Intent(this, kjchoiMainActivity1::class.java)
            startActivity(intent)
        }


        btn2.setOnClickListener {
            val intent = Intent(this, kjchoiMainActivity2::class.java)
            startActivity(intent)
        }


    }

    private fun callAction() {
        val number = Uri.parse("tel:010-2426-6038")
        val callIntent = Intent(Intent.ACTION_CALL, number);
        if(ActivityCompat.checkSelfPermission(this,android.Manifest.permission.CALL_PHONE)!= PackageManager.PERMISSION_GRANTED) {
            callAlertDlg()
        }
        else {
            startActivity(callIntent)
        }
    }

    private fun callAlertDlg() {
        val builder = AlertDialog.Builder(this)
        builder.setMessage("반드시 CALL_PHONE 권한이 허용되어야 합니다.")
            .setTitle("권한허용")
            .setPositiveButton("OK"){
                    _,_->ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.CALL_PHONE), CALL_REQUEST)
            }
        val dlg = builder.create()
        dlg.show()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when(requestCode){
            CALL_REQUEST->{
                if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
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
