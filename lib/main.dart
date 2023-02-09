import 'package:flutter/material.dart';


import 'detailpage.dart';
import 'mappage.dart';
import 'modal/Global.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'DetailPage': (context) => const DetailPage(),
        'MapPage': (context) => const MapPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Locator 1",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black12,
      body:  ListView.builder(
        itemCount: detail.length,
        itemBuilder: (context, index) {
          return  GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushNamed(context, 'DetailPage',arguments: detail[index]);
              });
            },
            child: Card(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Container(
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          "${detail[index]['Clogo']}",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("${detail[index]['Cname']}",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("${detail[index]['ceoname']}",style: TextStyle(color: Colors.black,fontSize: 20,),),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}