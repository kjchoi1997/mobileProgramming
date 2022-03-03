package com.example.kuvid19

import android.annotation.SuppressLint
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Shader
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

class SecondFragment :  Fragment() {
    @RequiresApi(Build.VERSION_CODES.O)
    var now = LocalDate.now()
    val scope = CoroutineScope(Dispatchers.IO)
    val age_key : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"
    var MyDataList = ArrayList<MyData2>()

    @RequiresApi(Build.VERSION_CODES.O)
    val date = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"))

    lateinit var url:String
    @SuppressLint("WrongConstant")
    @RequiresApi(Build.VERSION_CODES.N)
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View?
    {
        val rootView = inflater.inflate(R.layout.activity_second_fragment, container, false)
        init()
        printAgeData(rootView as ViewGroup)

        return rootView
    }

    @SuppressLint("WrongConstant")
    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    fun printAgeData(rootView:ViewGroup) {
        do {

        } while(MyDataList.size < 11)

        /*
             val gubun:String,               //구분
             val conf_case: Int,             //확진자
             val conf_case_rate : Float,    //확진률
             val death : Int ,               //사망자
             val death_rate:Float,          //사망률
             val critical_rate :Float      //치명률
          */

        val endIdx = MyDataList.size // 성별 따로 빼놓을거얌
        val MyData2Table: TableLayout = rootView.findViewById(R.id.MyData2Table)
        var idx = 0
        var shader: Shader
        val shaderColors = arrayOf<String>("#EA554A", "#CD245D", "#BD65CC", "#662ECA", "#8492DF", "#3E7AAA", "#16ACBF", "#009688", "#6AA16D", "#CDDC39")

        while(idx <= MyDataList.size-3) {
            val data: MyData2 = MyDataList.get(idx)

            // 동적 행 추가
            val tableRow = TableRow(context)
            //tableRow.layoutParams = MyData2Row.layoutParams
            tableRow.layoutParams = ViewGroup.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)

            // 열 레이아웃 설정
            val gubun = TextView(context)
            gubun.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            gubun.setTextColor(Color.parseColor("#302E2E"))
            gubun.setTextSize(15.0F)
            gubun.setPadding(5)
            gubun.textAlignment = 4

            gubun.text = data.gubun

            // 그라데이션 색 설정
            var paint = gubun.paint
            var width = paint.measureText(gubun.text.toString())
            shader = LinearGradient(0f, 0f, width, gubun.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            gubun.paint.setShader(shader)

            tableRow.addView(gubun)


            val conf_case = TextView(context)
            conf_case.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            conf_case.setTextColor(Color.parseColor("#302E2E"))
            conf_case.setTextSize(15.0F)
            conf_case.setPadding(5)
            conf_case.textAlignment = 4

            conf_case.text = data.conf_case.toString()

            // 그라데이션 색 설정
            paint = conf_case.paint
            width = paint.measureText(conf_case.text.toString())
            shader = LinearGradient(0f, 0f, width, conf_case.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            conf_case.paint.setShader(shader)

            tableRow.addView(conf_case)


            val conf_case_rate = TextView(context)
            conf_case_rate.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            conf_case_rate.setTextColor(Color.parseColor("#302E2E"))
            conf_case_rate.setTextSize(15.0F)
            conf_case_rate.setPadding(5)
            conf_case_rate.textAlignment = 4

            conf_case_rate.text = data.conf_case_rate.toString()

            // 그라데이션 색 설정
            paint = conf_case_rate.paint
            width = paint.measureText(conf_case_rate.text.toString())
            shader = LinearGradient(0f, 0f, width, conf_case_rate.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            conf_case_rate.paint.setShader(shader)

            tableRow.addView(conf_case_rate)


            val death = TextView(context)
            death.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            death.setTextColor(Color.parseColor("#302E2E"))
            death.setTextSize(15.0F)
            death.setPadding(5)
            death.textAlignment = 4

            death.text = data.death.toString()

            // 그라데이션 색 설정
            paint = death.paint
            width = paint.measureText(death.text.toString())
            shader = LinearGradient(0f, 0f, width, death.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            death.paint.setShader(shader)

            tableRow.addView(death)


            val death_rate = TextView(context)
            death_rate.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            death_rate.setTextColor(Color.parseColor("#302E2E"))
            death_rate.setTextSize(15.0F)
            death_rate.setPadding(5)
            death_rate.textAlignment = 4

            death_rate.text = data.death_rate.toString()

            // 그라데이션 색 설정
            paint = death_rate.paint
            width = paint.measureText(death_rate.text.toString())
            shader = LinearGradient(0f, 0f, width, death_rate.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            death_rate.paint.setShader(shader)

            tableRow.addView(death_rate)


            val critical_rate = TextView(context)
            critical_rate.setBackgroundResource(R.drawable.border_layout2) // 연령인 경우
            critical_rate.setTextColor(Color.parseColor("#302E2E"))
            critical_rate.setTextSize(15.0F)
            critical_rate.setPadding(5)
            critical_rate.textAlignment = 4

            critical_rate.text = data.critical_rate.toString()

            // 그라데이션 색 설정
            paint = critical_rate.paint
            width = paint.measureText(critical_rate.text.toString())
            shader = LinearGradient(0f, 0f, width, critical_rate.textSize, intArrayOf(
                Color.parseColor(shaderColors.get(idx)),
                Color.parseColor(shaderColors.get(idx+1))), null, Shader.TileMode.REPEAT)
            critical_rate.paint.setShader(shader)

            tableRow.addView(critical_rate)

            MyData2Table.addView(tableRow)
            idx++
        }
    }

    @RequiresApi(Build.VERSION_CODES.N)
    fun init() {
        scope.launch {
            //URLDecoder.decode(key, "UTF-8")
            /* url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19GenAgeCaseInfJson?serviceKey=" +
                     key + "&pageNo=1&numOfRows=10&STD_DAY=${date}}"
            */
            val url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19GenAgeCaseInfJson?serviceKey=" +
                    age_key + "&pageNo=1&numOfRows=10&startCreateDt=${date}&endCreateDt=${date}"
            val xml: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url)

            xml.documentElement.normalize()
            println("Root element : " + xml.documentElement.nodeName)

            MyDataList.clear()
            //찾고자 하는 데이터가 어느 노드 아래에 있는지 확인
            val list: NodeList = xml.getElementsByTagName("item")
            Log.e("lllll", list.length.toString())
            for (i in 0..list.length - 1) {
                var n: Node = list.item(i)
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    val elem = n as Element
                    val map = mutableMapOf<String, String>()

                    for (j in 0..elem.attributes.length - 1) {
                        map.putIfAbsent(
                            elem.attributes.item(j).nodeName,
                            elem.attributes.item(j).nodeValue
                        )
                    }
                    val gubun = elem.getElementsByTagName("gubun").item(0).textContent
                    val conf_case: Int =
                        elem.getElementsByTagName("confCase").item(0).textContent.toInt()
                    val conf_case_rate =
                        elem.getElementsByTagName("confCaseRate").item(0).textContent.toFloat()
                    val death: Int = elem.getElementsByTagName("death").item(0).textContent.toInt()
                    val death_rate =
                        elem.getElementsByTagName("deathRate").item(0).textContent.toFloat()
                    val critical_rate =
                        elem.getElementsByTagName("criticalRate").item(0).textContent.toFloat()

                    val data: MyData2 =
                        MyData2(gubun, conf_case, conf_case_rate, death, death_rate, critical_rate)
                    MyDataList.add(data)
                    Log.d("data", data.toString())

                }
            }
        }
    }
}