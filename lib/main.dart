import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());
var webdata;
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
// var webdata;
var data;
var cmd;
var iname;
var cname;
myweb({String cmd,String task=null,String name=null}) async {
  try {
     var url = "http://192.168.43.13/cgi-bin/web1.py?x=${task}&y=${name}&z=${cmd}";
    var response = await http.get(url);
    
    setState(() {
    webdata = response.body;
  });
  
  } catch (e) {
    setState(() {
    webdata = "Cannot Connect To Server";
  });
  
  }
 
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Docker Connect"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: null,
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(10),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              builder: (context, scrollController,) {
                  return SingleChildScrollView(
                    controller: scrollController,
                  child: Column(
              children: <Widget>[
                Text("Docker Menu",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                  ),),
                  SizedBox(height: 15,),
              Text("Docker Operation",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),),
              Row(children: <Widget>[
                 Card(
                  child: FlatButton(
                      onPressed: () {
                        myweb(cmd: "status",task: "system");
                      },
                      child: Text("Get Status")),
                ),
                 Container(
                   width: MediaQuery.of(context).size.width*0.2,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd:"start",task: "system");
                        },
                        child: Text("Start")),
                ),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width*0.2,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd:"stop",task: "system");
                        },
                        child: Text("Stop")),
                ),
                 ),
                Container(
                  width: MediaQuery.of(context).size.width*0.22,
                  child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd: "docker --version",task: "linux");
                        },
                        child: Text("Version")),
                  ),
                ),
              ],),
              Row(children: <Widget>[
                 Container(
                   width: MediaQuery.of(context).size.width*0.20,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd: "ls",task: "image");
                        },
                        child: Text("List all Images")),
                ),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width*0.25,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd: "docker container ps",task: "linux");
                        },
                        child: Text("List Running Containers")),
                ),
                 ),
                  Container(
                   width: MediaQuery.of(context).size.width*0.25,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd: "docker container ps -a",task: "linux");
                        },
                        child: Text("List all Containers")),
                ),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width*0.17,
                   child: Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(cmd: "docker --help",task: "linux");
                        },
                        child: Text("Help")),
                ),
                 ),
              ],),
              SizedBox(height: 15,),
              Text("Launch A Container",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),),
              Row(children: <Widget>[
                Container(
                width: MediaQuery.of(context).size.width*0.32,
                child: Card(child: TextField(
                  onChanged: (value) => iname = value ,
                  decoration: InputDecoration(hintText: "Image Name"),
                  ),
                  ),
              ),
               Container(
                width: MediaQuery.of(context).size.width*0.32,
                child: Card(child: TextField(
                  onChanged: (value) => cname =value,
                  decoration: InputDecoration(hintText: "Container Name"),
                ),),
              ),
              Card(
                child: FlatButton(onPressed: () => myweb(cmd: iname,name: cname,task: "container run"),
                 child: Text("launch")),
              )
              ],
              ),
              SizedBox(height: 15,),
              Text("Play With Container",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),),
              Row(children: <Widget>[
               
               Container(
                width: MediaQuery.of(context).size.width*0.33,
                child: Card(child: TextField(
                  onChanged: (value) => cname = value,
                  decoration: InputDecoration(hintText: "Container Name"),
                ),),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.17,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "start",task: "container opr",name: cname),
                   child: Text("Start")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.17,
                child: Card(
                  child: FlatButton(onPressed:() => myweb(cmd: "stop",task: "container opr",name: cname), 
                  child: Text("Stop")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "rm",name: cname,task: "container opr"),
                   child: Text("Delete")),
                ),
              )
              ],
              ),
              Text("For below menu enter above container name first",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  ),),
              Row(children: <Widget>[
                Container(
                width: MediaQuery.of(context).size.width*0.215,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "date",task: "exec",name: cname),
                   child: Text("Date")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.215,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "cal",task: "exec",name: cname), 
                  child: Text("Cal")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.215,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "ls",task: "exec",name: cname),
                   child: Text("ls")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.215,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: "inspect",task: "container opr",name: cname), 
                  child: Text("Inspect")),
                ),
              )
              ],),
               Row(children: <Widget>[
               
               Text("OR",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),),
             Container(
                width: MediaQuery.of(context).size.width*0.55,
                child: Card(child: TextField(onChanged: (value) => cmd = value,
                  decoration: InputDecoration(hintText: "Enter Your Docker Command Here"),
                ),),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(
                    cmd: cmd,task: "exec",name: cname), child: Text("Run command")),
                ),
              )
              ],
              ),
              SizedBox(height: 15,),
                 Row(children: <Widget>[
               
               Text("OR",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),),
             Container(
                width: MediaQuery.of(context).size.width*0.55,
                child: Card(child: TextField(onChanged: (value) => cmd = value,
                  decoration: InputDecoration(hintText: "Enter Your Linux Command Here"),
                ),),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Card(
                  child: FlatButton(onPressed: () => myweb(cmd: cmd,task: "linux"), child: Text("Run command")),
                ),
              )
              ],
              ),
                
                SizedBox(height: 15,),
                Card(
                  color: Colors.white,
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                    ),
                    width: double.infinity,
                    child: Text(webdata??"your output will be here"),
                ),
                ),
                 
                
              
              ],
            ) ,  
                  );
                })

          ),
        ),
      ),
    );
  }
}