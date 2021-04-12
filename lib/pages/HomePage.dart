import 'package:after_clicks/utils/routes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AFTER CLICKS"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // SvgPicture.asset(
              //   'assets/svg/undraw_jewelry_iima.svg',
              //   height: 300,
              //   // allowDrawingOutsideViewBox: true,
              // ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.solo);
                        },
                        child: Text("Solo"),
                      ),
                    ),
                    Expanded(child: SizedBox(width: 20)),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.collage);
                        },
                        child: Text("Collage"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Camera"),
                      ),
                    ),
                    Expanded(child: SizedBox(width: 20)),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.schedule);
                        },
                        child: Text("Schedule"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
