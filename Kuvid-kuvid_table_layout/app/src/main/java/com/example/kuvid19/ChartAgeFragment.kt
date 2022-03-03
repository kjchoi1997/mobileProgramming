package com.example.kuvid19

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.RequiresApi
import androidx.fragment.app.Fragment
import com.github.mikephil.charting.components.Legend
import com.github.mikephil.charting.components.XAxis
import com.github.mikephil.charting.data.BarData
import com.github.mikephil.charting.data.BarDataSet
import com.github.mikephil.charting.data.BarEntry
import com.github.mikephil.charting.formatter.IndexAxisValueFormatter
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

class ChartAgeFragment :  Fragment() {
    @RequiresApi(Build.VERSION_CODES.O)
    var now = LocalDate.now()
    val scope = CoroutineScope(Dispatchers.IO)
    //val age_sex_key : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"
    val key : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"
    val age_sex_key : String = "iTpYyrz%2B2quf9rhgNwrICe%2BksA%2B3VK6%2FQ%2FmWVn9UcOUfwTTVzvEnG%2B8MBYTXU2jlsWAOVIuOsrdsROX5t%2Btmrg%3D%3D"
    var MyDataList = ArrayList<MyData2>()
    @RequiresApi(Build.VERSION_CODES.O)
    val date = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
    val barDataList = ArrayList<BarEntry>()

    lateinit var url:String

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val rootView = inflater.inflate(R.layout.chart_age_fragment, container, false)
//        init()
        setBarChart(rootView as ViewGroup)
//        printAgeSexData(rootView as ViewGroup)

        return rootView
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        init()
    }

    fun setBarChart(rootView: ViewGroup) {
        do {

        } while(barDataList.size < 9)
        val chart:com.github.mikephil.charting.charts.BarChart = rootView.findViewById(R.id.chart)
        val xAxis: XAxis = chart.xAxis
        val xlabel = arrayOf("0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80이상")
        xAxis.valueFormatter = IndexAxisValueFormatter(xlabel)
        xAxis.position = XAxis.XAxisPosition.BOTTOM
        xAxis.granularity = 1f
        xAxis.textSize = 10f
        xAxis.textColor = Color.BLACK
        xAxis.setDrawAxisLine(false)
        xAxis.setDrawGridLines(false)

        chart.apply{
            legend.apply {
                textSize = 15f
                verticalAlignment = Legend.LegendVerticalAlignment.TOP
                horizontalAlignment = Legend.LegendHorizontalAlignment.CENTER
                orientation = Legend.LegendOrientation.HORIZONTAL
                setDrawInside(true)
            }
            setPinchZoom(false)
            setDrawBarShadow(false)
            setDrawGridBackground(false)
            setDrawBorders(false)
            setTouchEnabled(false)
            description.isEnabled = false
            isDoubleTapToZoomEnabled = false
        }

        chart.axisRight.isEnabled = false
        Log.d("bardata", barDataList.toString())
        val barDataSet = BarDataSet(barDataList, "연령별 확진자 ")
        barDataSet.color = Color.parseColor("#304567")
        barDataSet.formSize = 10f
        barDataSet.setDrawValues(false)
        barDataSet.valueTextSize = 12f
        val data = BarData(barDataSet)
        chart.data = data
        chart.invalidate()
        chart.animateY(1000)

    }

    @RequiresApi(Build.VERSION_CODES.N)
    fun init() {
        scope.launch {
//            URLDecoder.decode(key, "UTF-8")
            /* url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19GenAgeCaseInfJson?serviceKey=" +
                     key + "&pageNo=1&numOfRows=10&STD_DAY=${date}}"
            */
            val url =
                "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19GenAgeCaseInfJson?serviceKey=" +
                        age_sex_key + "&pageNo=1&numOfRows=10&startCreateDt=${date}&endCreateDt=${date}"
            val xml: Document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url)

            xml.documentElement.normalize()
            println("Root element : " + xml.documentElement.nodeName)

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
                    if(i < 9) {
                        barDataList.add(BarEntry(i.toFloat(), conf_case.toFloat()))
                    }
                    Log.d("data", data.toString())

                }
            }
        }
    }
}