package com.example.kuvid.main

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.os.Bundle
import android.util.Log
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.example.kuvid.R
import com.example.kuvid.news.ThirdActivity
import com.example.kuvid19.FourthActivity
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.BitmapDescriptorFactory
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import kotlinx.coroutines.*
import org.w3c.dom.Document
import org.w3c.dom.Element
import org.w3c.dom.Node
import org.w3c.dom.NodeList
import java.net.URLDecoder
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import javax.xml.parsers.DocumentBuilderFactory

class MainActivity : AppCompatActivity() {
    lateinit var googleMap: GoogleMap
    var center = LatLng(35.95, 128.25)
    var now = LocalDate.now()
    val scope = CoroutineScope(Dispatchers.IO)
    val key : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"
    var MyDataList = ArrayList<MyData>()
    var Title_loc_arr = arrayListOf<String>("제주도", "경상남도", "경상북도", "전라남도", "전라북도", "충청남도", "충청북도", "강원도"
            , "경기도", "세종특별자치시", "울산광역시", "대전광역시", "광주광역시", "인천광역시", "대구광역시", "부산광역시", "서울특별시")
    var City_loc_arr = arrayListOf<LatLng>(LatLng(33.49962, 126.53122), LatLng(35.23788, 128.69187), LatLng(36.57616, 128.50559)
            , LatLng(34.81637, 126.46292), LatLng(35.82054, 127.10871), LatLng(36.66043, 126.67252), LatLng(36.63596, 127.49132),
            LatLng(37.88565, 127.72971), LatLng(37.27502, 127.00917), LatLng(36.48092, 127.28868), LatLng(35.54032, 129.31132),
            LatLng(36.35068, 127.38474), LatLng(35.16058, 126.85176), LatLng(37.45614, 126.70591), LatLng(35.87172, 128.60172),
            LatLng(35.17991, 129.07501), LatLng(37.56646, 126.97800))
    // var Count_loc_arr = arrayListOf<Int>(653, 3157, 3672, 963, 1656, 2763, 2316, 2444, 30197, 325, 1258, 1523, 2234, 5335, 9063, 4301, 33856)
    // var IncDec_loc_arr = arrayListOf<Int>(7, 46, 26, 7, 23, 15, 12, 6, 202, 4, 25, 13, 1, 24, 5, 56, 200)

    var date = now.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 00"))

    lateinit var url : String
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(R.layout.activity_main)
        init()
        runBlocking {
            delay(2000)
        }
        initmap()
    }
    fun init() {
        scope.launch {
            URLDecoder.decode(key, "UTF-8")
            var url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=" +
                    key + "&pageNo=1&numOfRows=10&STD_DAY=${date}}"
            var xml: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url)
            xml.documentElement.normalize()
            println("Root element : " + xml.documentElement.nodeName)

            //찾고자 하는 데이터가 어느 노드 아래에 있는지 확인
            var list: NodeList = xml.getElementsByTagName("item")
            // Log.e("lllll", list.length.toString())
            if(list.length == 0) {
                val past = now.minusDays(1)
                date = past.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
            }
            url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=" +
                    key + "&pageNo=1&numOfRows=10&STD_DAY=${date}}"
            xml = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url)
            xml.documentElement.normalize()
            println("Root element : " + xml.documentElement.nodeName)

            //찾고자 하는 데이터가 어느 노드 아래에 있는지 확인
            list = xml.getElementsByTagName("item")
            for (i in 0..list.length - 1) {
                var n: Node = list.item(i)
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    val elem = n as Element
                    val map = mutableMapOf<String, String>()

                    for (j in 0..elem.attributes.length - 1) {
                        map.putIfAbsent( elem.attributes.item(j).nodeName, elem.attributes.item(j).nodeValue)
                    }
                    val gubun = elem.getElementsByTagName("gubun").item(0).textContent
                    val def_cnt: Int = elem.getElementsByTagName("defCnt").item(0).textContent.toInt()
                    val iso_ing_cnt: Int = elem.getElementsByTagName("isolIngCnt").item(0).textContent.toInt()
                    val death_cnt: Int = elem.getElementsByTagName("deathCnt").item(0).textContent.toInt()
                    val iso_clear_cnt = elem.getElementsByTagName("isolClearCnt").item(0).textContent.toInt()
                    val inc_dec: Int = elem.getElementsByTagName("incDec").item(0).textContent.toInt()

                    val data: MyData = MyData(gubun, def_cnt, iso_ing_cnt, death_cnt, iso_clear_cnt, inc_dec)
                    MyDataList.add(data)
                    Log.d("data", data.toString())
                }
            }
        }
        val button = findViewById<Button>(R.id.startbutton)
        button.setOnClickListener {
            val intent = Intent(this, ThirdActivity::class.java)
            startActivity(intent)
        }
        val button2 = findViewById<Button>(R.id.button2)
        button2.setOnClickListener {
            val intent = Intent(this, FourthActivity::class.java)
            startActivity(intent)
        }
    }
    private fun initmap() {
        val mapFragment = supportFragmentManager.findFragmentById(R.id.map) as SupportMapFragment
        // google이 ready 된 상태의 함수 내용을 적어주면 됨.
        mapFragment.getMapAsync {
            googleMap = it
            Log.e("lllll", MyDataList.size.toString())
            // googleMap 객체가 지정이 됬으니까 원하는 위치로 이동시켜주면 됨.
            googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(City_loc_arr[16], 7.0f))
            // 최대 최소의 zoom값도 정해줄 수 있음.
            googleMap.setMinZoomPreference(5.0f)
            googleMap.setMaxZoomPreference(9.0f)
            // loc 위치에 마커를 찍어주고 그에 대한 title, info를 적어서 window로 띄워줌.
            for(i in 0 until City_loc_arr.size) {
                val option = MarkerOptions()
                option.position(City_loc_arr[i])
                val det_num = MyDataList[i + 1].inc_dec.toDouble() / MyDataList[i + 1].def_cnt.toDouble()
                // val det_num = Count_loc_arr[i].toDouble() / IncDec_loc_arr[i]
                var bitmapdraw:BitmapDrawable
                when (det_num) {
                    in 0.0..0.001 -> bitmapdraw = resources.getDrawable(R.drawable.virus1) as BitmapDrawable
                    in 0.001..0.003 -> bitmapdraw = resources.getDrawable(R.drawable.virus2) as BitmapDrawable
                    in 0.003..0.005 -> bitmapdraw = resources.getDrawable(R.drawable.virus3) as BitmapDrawable
                    else -> bitmapdraw = resources.getDrawable(R.drawable.virus4) as BitmapDrawable
                }
                var b = bitmapdraw.bitmap as Bitmap
                var marker = Bitmap.createScaledBitmap(b, 100, 100, false)
                option.icon(BitmapDescriptorFactory.fromBitmap(marker))
                option.title(Title_loc_arr[i])
                option.snippet("확진자 수 : " + MyDataList[i + 1].def_cnt + "  전날 대비 증감 수 : " + MyDataList[i + 1].inc_dec)
                // option.snippet("확진자 수 : " + Count_loc_arr[i].toString() + "  전날 대비 증감 수 : " + IncDec_loc_arr[i])
                val mk = googleMap.addMarker(option)
                mk.showInfoWindow()
            }
            googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(center, 7.0f))
        }
    }
}