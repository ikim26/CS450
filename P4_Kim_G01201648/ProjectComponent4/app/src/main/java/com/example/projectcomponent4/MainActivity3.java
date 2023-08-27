package com.example.projectcomponent4;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import com.example.project10.R;

public class MainActivity3 extends AppCompatActivity {
    String txns ="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);
        Intent intent = getIntent();
        txns = intent.getStringExtra("txns");
        TextView textView2 = findViewById(R.id.tv2);

        //set text to server output for now
        textView2.setText(txns);

        /*
        ADD TABLE IMPLEMENTATION HERE
         */

    }
}
