package com.example.my_english_word.DB

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.util.Log
import com.example.my_english_word.MyData
import java.lang.Math.abs

class MyDBHelper(val context:Context):SQLiteOpenHelper(context, DB_NAME, null, DB_VERSION) {
    companion object{
        val DB_NAME = "mydb.db"
        val DB_VERSION = 1
        val TABLE_NAME = "words"
        val PID =  "pid"
        val PWORD = "pword"
        val PMEAN = "pmean"
        val PFAVORITE = "pfavorite"
        val PWRONG = "pwrong"
    }

//    val strsql = "select * from $TABLE_NAME;"

    fun makeDataArray(cursor : Cursor): ArrayList<MyData> {
        var tmpData : ArrayList<MyData> = ArrayList()

        while(cursor.moveToNext()){
            val pid = cursor.getString(0).toInt()
            val word = cursor.getString(1)
            val meaning = cursor.getString(2)
            val favorite = cursor.getString(3).toInt()
            val wrong = cursor.getString(4).toInt()
            tmpData.add(MyData(pid, word, meaning, favorite, wrong))
        }
        return tmpData
    }

    fun getRandomWrongData(count : Int):ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME where $PWRONG=1 order by random() limit $count"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun getRandomData(count : Int):ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME where $PWRONG=0 order by random() limit $count"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun findWord(word : String):ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME where $PWORD like '$word%';"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun getWrongData():ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME where $PWRONG=1;"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun getFavoriteData():ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME where $PFAVORITE=1;"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun getAllData():ArrayList<MyData>{
        val strsql = "select * from $TABLE_NAME;"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        return makeDataArray(cursor)
    }

    fun updateWord(data : MyData):Boolean{
        val pid = data.pid
        val strsql = "select * from $TABLE_NAME where $PID='$pid';"
        val db = writableDatabase
        val cursor = db.rawQuery(strsql, null)
        val flag = cursor.count !=0
        if(flag){
            cursor.moveToFirst()
            val values = ContentValues()
            values.put(PWORD, data.word)
            values.put(PMEAN, data.meaning)
            values.put(PFAVORITE, data.favorite)
            values.put(PWRONG, data.wrong)
            db.update(TABLE_NAME, values, "$PID=?", arrayOf(pid.toString()))
        }
        cursor.close()
        db.close()
        return flag
    }

    fun insertWord(data: MyData) : Boolean{
        val values = ContentValues()
        values.put(PWORD, data.word)
        values.put(PMEAN, data.meaning)
        values.put(PFAVORITE, data.favorite)
        values.put(PWRONG, data.wrong)

        val db = writableDatabase
        val flag = db.insert(TABLE_NAME, null, values) > 0
        db.close()
        return flag
    }

    override fun onCreate(db: SQLiteDatabase?) {
        val create_table = "create table if not exists $TABLE_NAME("+
                                    "$PID integer primary key autoincrement," +
                                    "$PWORD text, " +
                                    "$PMEAN text," +
                                    "$PFAVORITE integer," +
                                    "$PWRONG integer);"
        db!!.execSQL(create_table)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        val drop_table = "drop table if exists $TABLE_NAME"
        db!!.execSQL(drop_table)
        onCreate(db)
    }
}