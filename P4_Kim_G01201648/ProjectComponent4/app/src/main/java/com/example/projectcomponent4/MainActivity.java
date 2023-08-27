package com.example.projectcomponent4;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.project10.R;

public class MainActivity extends AppCompatActivity {
    String cid="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        EditText editText=findViewById(R.id.editText);
        EditText editText2=findViewById(R.id.editText2);

        //login button
        Button button=findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RequestQueue queue= Volley.newRequestQueue(MainActivity.this);
                String username=editText.getText().toString();
                String password=editText2.getText().toString();
                String url="http://10.0.2.2:8080/loyaltyfirst/login?user="+username+"&pass="+password;
                StringRequest request=new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        if(s.trim().equals("No")){
                            Toast.makeText(MainActivity.this,"Invalid Username or Password",Toast.LENGTH_LONG).show();
                        }
                        else{
                            String[] result=s.trim().split(":");
                            cid=result[1];
                            Intent intent=new Intent(MainActivity.this,MainActivity2.class);
                            intent.putExtra("cid",cid);
                            startActivity(intent);
                        }
                    }
                },null);
                queue.add(request);
            }
        });
    }
}