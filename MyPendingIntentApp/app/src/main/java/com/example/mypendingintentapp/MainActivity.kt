package com.example.mypendingintentapp

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NotificationCompat
import com.example.mypendingintentapp.databinding.ActivityMainBinding
import com.example.mypendingintentapp.databinding.MypickerdlgBinding
import java.util.*

class MainActivity : AppCompatActivity() {
    lateinit var binding:ActivityMainBinding
    var mymemo = ""
    var myhour = 0
    var myminute = 0
    var message = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        val str = intent.getStringExtra("time")
        if(str!=null){
            Toast.makeText(this, str, Toast.LENGTH_SHORT).show()
        }
        init()
    }

    private fun init() {
        binding.calendarView.setOnDateChangeListener { view, year, month, dayOfMonth ->
            val dlgBinding = MypickerdlgBinding.inflate(layoutInflater)
            val dlgBuilder = AlertDialog.Builder(this)
            dlgBuilder.setView(dlgBinding.root)
                .setPositiveButton("추가"){
                    _,_->
                   mymemo = dlgBinding.editText.text.toString()
                   myhour = dlgBinding.timePicker.hour
                   myminute = dlgBinding.timePicker.minute
                   message = myhour.toString() + "시" + myminute.toString()+"분"+mymemo
                   val timerTask = object:TimerTask(){
                       override fun run() {
                           makeNotification()
                       }
                   }
                    val timer = Timer()
                    timer.schedule(timerTask, 2000)
                    Toast.makeText(this,"알림이 추가되었음", Toast.LENGTH_SHORT).show()
                }
                .setNegativeButton("취소"){
                    _,_->
                }
                .show()
/*            val dlg = dlgBuilder.create()
            dlg.show()*/
        }
    }

    fun makeNotification(){
        val id = "MyChannel"
        val name = "TimeCheckChannel"
        val notificationChannel = NotificationChannel(id, name, NotificationManager.IMPORTANCE_DEFAULT)
        notificationChannel.enableLights(true)
        notificationChannel.enableVibration(true)
        notificationChannel.lightColor = Color.BLUE
        notificationChannel.lockscreenVisibility = Notification.VISIBILITY_PRIVATE

        val builder = NotificationCompat.Builder(this, id)
            .setSmallIcon(R.drawable.ic_baseline_access_alarm_24)
            .setContentTitle("일정 알람")
            .setContentText(message)
            .setAutoCancel(true)

        val intent = Intent(this, MainActivity::class.java)
        intent.putExtra("time", message)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP

        val pendingIntent = PendingIntent.getActivity(this, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT)
        builder.setContentIntent(pendingIntent)



        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(notificationChannel)
        val notification = builder.build()
        manager.notify(10, notification)


    }

}