import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> alldetail =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "${alldetail['Cname']}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<Position?>(
        stream: Geolocator.getPositionStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Position? data = snapshot.data;

            placemarkFromCoordinates(alldetail['lat'], alldetail['log'])
                .then((List<Placemark> placemarks) {
              setState(() {
                placemark = placemarks[0];
              });
            });
            return (data != null)
                ? Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 3, right: 20),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                      ),
                                      child: CircleAvatar(
                                        maxRadius: 70,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              "${alldetail['Clogo']}",
                                              fit: BoxFit.fill,
                                              height: 90,
                                              width: 90,
                                            )),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${alldetail['Cname']}",
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "CEO",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Company Details",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Container(
                                              height: 120,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 2),
                                                color: Colors.blue,
                                              ),
                                              child: Image.network(
                                                  "${alldetail['coepick']}",
                                                  fit: BoxFit.cover,
                                                  height: 104)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Card(
                                                      elevation: 3,
                                                      child: Text(
                                                        "${alldetail['ceoname']}",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Card(
                                                        elevation: 2,
                                                        child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.blue,
                                                    )),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          Navigator.pushNamed(context, 'MapPage' , arguments: alldetail);
                                                        });
                                                      },
                                                      child: Card(
                                                        elevation: 2,
                                                        child: Text(
                                                          "Click here for get location",
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          "Name : ${(placemark != null) ? placemark!.name : Container()}"),
                                      Text(
                                          "Street : ${(placemark != null) ? placemark!.street : Container()}"),
                                      Text(
                                          "Locality : ${(placemark != null) ? placemark!.locality : Container()}"),
                                      Text(
                                          "Country : ${(placemark != null) ? placemark!.country : Container()}"),
                                      Text(
                                          "PostalCode : ${(placemark != null) ? placemark!.postalCode : Container()}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Company Deccription",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 1),
                                        child: Text(
                                          "${alldetail['dis']}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
