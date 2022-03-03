package com.example.final201712099

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.example.final201712099.databinding.KjchoiactivityMainBinding
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.BitmapDescriptorFactory
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import java.io.FileOutputStream

class kjchoiMainActivity : AppCompatActivity(){
    lateinit var binding: KjchoiactivityMainBinding
    lateinit var broadcastReceiver: BroadcastReceiver
    lateinit var googleMap: GoogleMap
    lateinit var myDBHelper: kjchoiMyDBHelper
    lateinit var myplacedata: kjchoiMyData
    var loc = LatLng(37.554752, 126.970631)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = KjchoiactivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        initmap()
        initDB()
        init()
        initPermission()
        initMess()
        if(intent.hasExtra("msg")){
            val msg = intent.getStringExtra("msg")
            Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
        }

    }

    private fun initDB() {
        val dbfile = getDatabasePath("mydb.db")
        if(!dbfile.parentFile.exists()){
            dbfile.parentFile.mkdir()
        }
        if(!dbfile.exists()){
            val file = resources.openRawResource(R.raw.mydb)
            val fileSize = file.available()
            val buffer = ByteArray(fileSize)
            file.read(buffer)
            file.close()
            dbfile.createNewFile()
            val output = FileOutputStream(dbfile)
            output.write(buffer)
            output.close()
        }
    }

    private fun initmap() {
        val mapFragment = supportFragmentManager.findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync{
            googleMap = it
            googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(loc, 16.0f))
            googleMap.setMinZoomPreference(10.0f)
            googleMap.setMaxZoomPreference(18.0f)
            val option = MarkerOptions()
            option.position(loc)
            option.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN))
            option.title("서울역")
            option.snippet("201712099 최규진")
            val mk1 = googleMap.addMarker(option)
            mk1.showInfoWindow()
        }
    }
    private fun init(){
        myDBHelper = kjchoiMyDBHelper(this)
        binding.apply{

            searchbutton.setOnClickListener{
                var place = cityEdit.text.toString()
                myplacedata = myDBHelper.findPlace(place)
                var latitude = myplacedata.pLatitude
                var longitude = myplacedata.pLongitude
                loc = LatLng(latitude, longitude)
                initmap2()
            }
        }
    }

    private fun initmap2() {
        val mapFragment = supportFragmentManager.findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync{
            googleMap = it
            googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(loc, 16.0f))
            googleMap.setMinZoomPreference(10.0f)
            googleMap.setMaxZoomPreference(18.0f)
            val option = MarkerOptions()
            option.position(loc)
            option.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN))
            option.title(myplacedata.pCity)
            option.snippet(myplacedata.pInfo)
            val mk1 = googleMap.addMarker(option)
            mk1.showInfoWindow()
        }
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        if(intent != null){
            if(intent.hasExtra("msg")){
                val msg = intent.getStringExtra("msg")
                Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
            }
        }
    }

    fun initMess(){
        broadcastReceiver = object : BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent?) {
                if (intent != null) {
                    if(intent.action.equals(Intent.ACTION_POWER_CONNECTED))
                        Toast.makeText(context, "배터리 충전 시작", Toast.LENGTH_SHORT).show()
                }
            }

        }
    }
    fun initPermission(){
        if(Build.VERSION.SDK_INT >= 29){
            if(!Settings.canDrawOverlays(this)){
                val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:$packageName"))
                startActivity(intent)
            }
        }
        if(ActivityCompat.checkSelfPermission(this, Manifest.permission.RECEIVE_SMS) == PackageManager.PERMISSION_GRANTED){
            Toast.makeText(this, "문자 수신 동의함.", Toast.LENGTH_SHORT).show()

        }
        else{
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECEIVE_SMS), 100)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if(requestCode == 100){
            if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
                Toast.makeText(this, "문자 수신 동의함.", Toast.LENGTH_SHORT).show()
            }
            else{
                Toast.makeText(this, "문자 수신 동의 필요함.", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        val filter = IntentFilter()
        filter.addAction(Intent.ACTION_POWER_CONNECTED)
        registerReceiver(broadcastReceiver, filter)
    }

    override fun onPause() {
        super.onPause()
        unregisterReceiver(broadcastReceiver)
    }


}