import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hc_meme_generator/widgets/app_drawer.dart';

class EditingScreen extends StatefulWidget {
  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  final GlobalKey globalKey = new GlobalKey();

  String headerText = "Sample Header Text";
  String footerText = "Sample Footer Text";
  Color textColor = Colors.blue;
  Color backgroundColor = Colors.black;
  double upperSpace = 40;
  double bottomSpace = 40;

 



  void changeTextColor(Color color) => setState(() => textColor = color);
  void changebackgroundColor(Color color) => setState(() => backgroundColor = color);

  bool imageSelected = false;

  Random rng = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Meme Generator"),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
             Text("Choose Colors " , style: Theme.of(context).textTheme.title,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 RaisedButton(
                        elevation: 3.0,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                contentPadding: const EdgeInsets.all(0.0),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: textColor,
                                    onColorChanged: changeTextColor,
                                    colorPickerWidth: 300.0,
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: true,
                                    displayThumbColor: true,
                                    showLabel: true,
                                    paletteType: PaletteType.hsv,
                                    pickerAreaBorderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(2.0),
                                      topRight: const Radius.circular(2.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Text Color'),
                        color: textColor,
                        textColor: Colors.white,
                      ),
                       RaisedButton(
                        elevation: 3.0,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                contentPadding: const EdgeInsets.all(0.0),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: backgroundColor,
                                    onColorChanged: changebackgroundColor,
                                    colorPickerWidth: 300.0,
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: true,
                                    displayThumbColor: true,
                                    showLabel: true,
                                    paletteType: PaletteType.hsv,
                                    pickerAreaBorderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(2.0),
                                      topRight: const Radius.circular(2.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Background Color'),
                        color: backgroundColor,
                        textColor: Colors.white,
                      ),
               ],
             ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Set Upper Space",
                    style: Theme.of(context).textTheme.subtitle),
                Slider(
                  min: 0,
                  max: 100,
                  value: upperSpace,
                  onChanged: (value) {
                    setState(() {
                      upperSpace = value;
                    });
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
            
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Header Text",
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 22),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                    hintStyle: Theme.of(context).textTheme.subtitle),
                onChanged: (value) {
                  setState(() {
                    headerText = value;
                  });
                },
                style: TextStyle(color: Colors.blue),
              ),
            ),
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 220 + bottomSpace + upperSpace,
                    color: backgroundColor,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: upperSpace,
                        ),
                        Image.asset(
                          'assets/images/IMG-002.jpg',
                          height: 220,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: bottomSpace,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220 + bottomSpace + upperSpace,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(
                            headerText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22.0,
                              
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(
                            footerText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22.0,
                             
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Footer Text",
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 22),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                    hintStyle: Theme.of(context).textTheme.subtitle),
                onChanged: (value) {
                  setState(() {
                    footerText = value;
                  });
                },
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Set Lower Space",
                    style: Theme.of(context).textTheme.subtitle),
                Slider(
                  min: 0,
                  max: 60,
                  value: bottomSpace,
                  onChanged: (value) {
                    setState(() {
                      bottomSpace = value;
                    });
                  },
                ),
                
              ],
            ),
            SizedBox(height:530)
          ],
        ),
      ),
    );
  }
}
