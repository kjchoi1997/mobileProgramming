package com.example.final201712099

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

class kjchoiMyDBHelper(val context: Context) : SQLiteOpenHelper(context, DB_NAME, null, DB_VERSION) {
    companion object{
        val DB_NAME = "mydb.db"
        val DB_VERSION = 1
        val TABLE_NAME = "mylocation"
        val PID = "pid"
        val PLATITUDE = "platitude"
        val PLONGITUDE = "plongitude"
        val PCITY = "pcity"
        val PINFO = "pinfo"
    }
    lateinit var placedata: kjchoiMyData


    override fun onCreate(db: SQLiteDatabase?) {
        val create_table = "create table if not exists $TABLE_NAME("+
                "$PID integer primary key autoincrement, "+
                "$PLATITUDE double, "+
                "$PLONGITUDE double, "+
                "$PCITY text, "+
                "$PINFO text);"
        db!!.execSQL(create_table)
        initData()
    }

    private fun initData() {
        val strsql = "select * from $TABLE_NAME"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        cursor.moveToFirst()
        val attrcount = cursor.columnCount
        for(i in 0 until attrcount) {
            val values = ContentValues()
            values.put(PID, cursor.getInt(0))
            values.put(PLATITUDE, cursor.getDouble(1))
            values.put(PLONGITUDE, cursor.getDouble(2))
            values.put(PCITY, cursor.getString(3))
            values.put(PINFO, cursor.getString(4))
            db.insert(TABLE_NAME, null, values)
        }
        db.close()
    }

    fun findPlace(city: String): kjchoiMyData {
        val strsql = "select * from $TABLE_NAME where $PCITY = '$city';"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        cursor.moveToFirst()
        placedata.pId = cursor.getInt(0)
        placedata.pLatitude = cursor.getDouble(1)
        placedata.pLongitude = cursor.getDouble(2)
        placedata.pCity = cursor.getString(3)
        placedata.pInfo = cursor.getString(4)
        return placedata
    }

    fun insertProduct(data: kjchoiMyData): Boolean{
        val values = ContentValues()
        values.put(PID, data.pId)
        values.put(PLATITUDE, data.pLatitude)
        values.put(PLONGITUDE, data.pLongitude)
        values.put(PCITY, data.pCity)
        values.put(PINFO, data.pInfo)
        val db = writableDatabase
        val flag = db.insert(TABLE_NAME, null, values) > 0
        db.close()
        return flag
    }
    fun getAllRecord(){
        val strsql = "select * from $TABLE_NAME"
        val db = readableDatabase
        val cursor = db.rawQuery(strsql, null)
        //if(count != 0)
        cursor.close()
        db.close()
    }


    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        val drop_table = "drop table if exists $TABLE_NAME;"
        db!!.execSQL(drop_table)

    }



}