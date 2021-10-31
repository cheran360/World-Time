import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    //set background
    String bgImage = data['isDaytime'] ? 'daytime.jpg' : 'nighttime.jpg';
    Color? bgcolor = data['isDaytime'] ? Colors.black87 : Colors.white;

    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location, color: bgcolor),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: bgcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location']!,
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: bgcolor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 63.0,
                    color: bgcolor,
                  ),
                ),
                const SizedBox(height: 10.0),
                SpinKitWave(
                  color: bgcolor,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
