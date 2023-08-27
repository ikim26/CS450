package com.example.projectcomponent4;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.ImageRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.project10.R;

public class MainActivity2 extends AppCompatActivity {
String cid ="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        Intent intent = getIntent();
        cid = intent.getStringExtra("cid");
        TextView textView = findViewById(R.id.tv2);
        ImageView imageView = findViewById(R.id.imageView);
        RequestQueue queue = Volley.newRequestQueue(this);

        //button for MainActivity3
        Button button2=findViewById(R.id.button2);
        button2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                String url="http://10.0.2.2:8080/loyaltyfirst/Transactions.jsp?cid="+cid;
                StringRequest request=new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        Intent intent1=new Intent(MainActivity2.this,MainActivity3.class);
                        intent1.putExtra("txns",s);
                        startActivity(intent1);
                    }
                },null);
                queue.add(request);
            }
        });

        //to display name of customer
        String url = "http://10.0.2.2:8080/loyaltyfirst/Info.jsp?cid=" + cid;
        StringRequest request = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                String[] result = s.trim().split(",");
                String name = result[0];
                String points = result[1];
                textView.setText("Welcome\n" + name + "\nNumber of points: " + points.replace("#", ""));
            }
        }, null);
        queue.add(request);

        //to display image of customer
        String url2 = "http://10.0.2.2:8080/loyaltyfirst/images/" + cid + ".jpeg";
        ImageRequest request2 = new ImageRequest(url2, new Response.Listener<Bitmap>() {
            @Override
            public void onResponse(Bitmap bitmap) {
                imageView.setImageBitmap(bitmap);
            }
        }, 0, 0, null, null);
        queue.add(request2);
    }
}