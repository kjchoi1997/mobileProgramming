package com.example.final201712099

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.SmsMessage
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class kjchoiMyReceiver: BroadcastReceiver() {

    val cityhallPattern = Regex("""^[가-힣a-zA-Z0-9]+$""")
    val scope = CoroutineScope(Dispatchers.IO)
    override fun onReceive(context: Context, intent: Intent) {
        // This method is called when the BroadcastReceiver is receiving an Intent broadcast.
        val pendingResult = goAsync()
        scope.launch{
            if(intent.action.equals("android.provider.Telephony.SMS_RECEIVED")){
                val bundle = intent.extras
                val objects = bundle?.get("pdus") as Array<Any>
                val sms = objects[0] as ByteArray
                val format = bundle.getString("format")
                val message = SmsMessage.createFromPdu(sms, format)
                val msg = message.messageBody
                if(msg.contains("city hall")) {
                    val tempstr = msg.split("\n")
                    var resultstr = ""
                    for(str in tempstr.subList(1,tempstr.size)){
                        if(cityhallPattern.containsMatchIn(str)){
                            resultstr += "$str : "
                        }
                    }
                    if(!resultstr.isEmpty()) {
                        val newIntent = Intent(context, kjchoiMainActivity::class.java)
                        newIntent.flags =
                                Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
                        newIntent.putExtra("msg", resultstr)
                        context.startActivity(newIntent)
                    }
                }
            }
            pendingResult.finish()
        }
    }
}