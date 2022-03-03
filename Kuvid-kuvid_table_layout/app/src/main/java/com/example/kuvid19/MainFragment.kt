package com.example.kuvid19

import android.annotation.SuppressLint
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TableLayout
import android.widget.TableRow
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.core.view.setPadding
import androidx.fragment.app.Fragment
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.w3c.dom.Document
import org.w3c.dom.Element
import org.w3c.dom.Node
import org.w3c.dom.NodeList
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import javax.xml.parsers.DocumentBuilderFactory

class MainFragment :  Fragment() {
    @RequiresApi(Build.VERSION_CODES.O)
    var now = LocalDate.now()
    val scope = CoroutineScope(Dispatchers.IO)
    val key_area : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"

    var MyDataList = ArrayList<MyData>()
    @RequiresApi(Build.VERSION_CODES.O)
    val date = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"))

    @SuppressLint("WrongConstant")
    @RequiresApi(Build.VERSION_CODES.N)
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View?
    {
        val rootView = inflater.inflate(R.layout.activity_main_fragment, container, false)
        init()
        printAreaData(rootView as ViewGroup)

        return rootView
    }

    @SuppressLint("WrongConstant")
    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    fun printAreaData(rootView:ViewGroup ) {
        //##### MyDataList : area data
        // 데이터 받으려고 기달
        do {

        } while(MyDataList.size < 19)

        /*
            val gubun : String,         //지역
            val def_cnt: Int,           //확진자수
            val iso_ing_cnt : Int,      //격리자수
            val death_cnt : Int,        //사망자
            val iso_clear_cnt:Int,      //격리해제수
            val inc_dec : Int           //전일대비 증감
         */

        val outIdx = 0 // 해외 유입 따로 빼놓을거얌
        val sumIdx = MyDataList.size // 합계 따로 빼놓을거얌
        var idx = 0

        val MyDataList_it = MyDataList.iterator()
        val MyData1Table:TableLayout = rootView.findViewById(R.id.MyData1Table)

        while(MyDataList_it.hasNext()) {
            val data: MyData = MyDataList_it.next()

            // 동적 행 추가
            val tableRow = TableRow(context)
            //tableRow.layoutParams = MyDataRow.layoutParams
            tableRow.layoutParams = ViewGroup.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)

            // 열 레이아웃 설정
            val gubun = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) gubun.setBackgroundResource(R.drawable.border_layout_es)
            else gubun.setBackgroundResource(R.drawable.border_layout)

            gubun.setTextColor(Color.parseColor("#ECE8CA"))
            gubun.setTextSize(15.0F)
            gubun.setPadding(5)
            gubun.textAlignment = 4

            gubun.text = data.gubun
            tableRow.addView(gubun)


            val def_cnt = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) def_cnt.setBackgroundResource(R.drawable.border_layout_es)
            else def_cnt.setBackgroundResource(R.drawable.border_layout)

            def_cnt.setTextColor(Color.parseColor("#ECE8CA"))
            def_cnt.setTextSize(15.0F)
            def_cnt.setPadding(5)
            def_cnt.textAlignment = 4

            def_cnt.text = data.def_cnt.toString()
            tableRow.addView(def_cnt)


            val iso_ing_cnt = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) iso_ing_cnt.setBackgroundResource(R.drawable.border_layout_es)
            else iso_ing_cnt.setBackgroundResource(R.drawable.border_layout)

            iso_ing_cnt.setTextColor(Color.parseColor("#ECE8CA"))
            iso_ing_cnt.setTextSize(15.0F)
            iso_ing_cnt.setPadding(5)
            iso_ing_cnt.textAlignment = 4

            iso_ing_cnt.text = data.iso_ing_cnt.toString()
            tableRow.addView(iso_ing_cnt)


            val death_cnt = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) death_cnt.setBackgroundResource(R.drawable.border_layout_es)
            else death_cnt.setBackgroundResource(R.drawable.border_layout)

            death_cnt.setTextColor(Color.parseColor("#ECE8CA"))
            death_cnt.setTextSize(15.0F)
            death_cnt.setPadding(5)
            death_cnt.textAlignment = 4

            death_cnt.text = data.death_cnt.toString()
            tableRow.addView(death_cnt)


            val iso_clear_cnt = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) iso_clear_cnt.setBackgroundResource(R.drawable.border_layout_es)
            else iso_clear_cnt.setBackgroundResource(R.drawable.border_layout)

            iso_clear_cnt.setTextColor(Color.parseColor("#ECE8CA"))
            iso_clear_cnt.setTextSize(15.0F)
            iso_clear_cnt.setPadding(5)
            iso_clear_cnt.textAlignment = 4

            iso_clear_cnt.text = data.iso_clear_cnt.toString()
            tableRow.addView(iso_clear_cnt)



            val inc_dec = TextView(context)
            if(outIdx == idx || sumIdx-1 == idx) inc_dec.setBackgroundResource(R.drawable.border_layout_es)
            else inc_dec.setBackgroundResource(R.drawable.border_layout)

            inc_dec.setTextColor(Color.parseColor("#ECE8CA"))
            inc_dec.setTextSize(15.0F)
            inc_dec.setPadding(5)
            inc_dec.textAlignment = 4

            inc_dec.text = data.inc_dec.toString()
            tableRow.addView(inc_dec)

            MyData1Table.addView(tableRow)
            idx++
        }
    }

    @RequiresApi(Build.VERSION_CODES.N)
    fun init() {
        scope.launch {
            //URLDecoder.decode(key, "UTF-8")
            val area_url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=" +
                    key_area + "&pageNo=1&numOfRows=10&startCreateDt=${date}&endCreateDt=${date}"
            val area_xml: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(area_url)

            area_xml.documentElement.normalize()
            println("Root element : " + area_xml.documentElement.nodeName)

            MyDataList.clear()

            //찾고자 하는 데이터가 어느 노드 아래에 있는지 확인
            val request : NodeList = area_xml.getElementsByTagName("item")
            Log.e("lllll", request.length.toString())

            for(i in 0..request.length-1) {
                var n: Node = request.item(i)
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    val elem = n as Element
                    val map = mutableMapOf<String, String>()

                    for (j in 0..elem.attributes.length - 1) {
                        map.putIfAbsent(elem.attributes.item(j).nodeName, elem.attributes.item(j).nodeValue)
                    }
                    val gubun = elem.getElementsByTagName("gubun").item(0).textContent
                    val def_cnt: Int = elem.getElementsByTagName("defCnt").item(0).textContent.toInt()
                    val iso_ing_cnt : Int = elem.getElementsByTagName("isolIngCnt").item(0).textContent.toInt()
                    val death_cnt : Int = elem.getElementsByTagName("deathCnt").item(0).textContent.toInt()
                    val iso_clear_cnt = elem.getElementsByTagName("isolClearCnt").item(0).textContent.toInt()
                    val inc_dec : Int = elem.getElementsByTagName("incDec").item(0).textContent.toInt()

                    val data: MyData = MyData(gubun, def_cnt, iso_ing_cnt, death_cnt, iso_clear_cnt, inc_dec)
                    MyDataList.add(data)
                    Log.d("data", data.toString())
                }
            }
        }
    }
}