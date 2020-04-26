import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:photo_view/photo_view.dart';
import '../screens/photoviewScreen.dart';

class EditingScreen extends StatefulWidget {
  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  final GlobalKey globalKey = new GlobalKey();

  String headerText = "";
  String footerText = "";
  Color textColor = Colors.black;
  Color backgroundColor = Colors.amber;
  double upperSpace = 40;
  double bottomSpace = 40;

  Random rng = new Random();

  File _imageFile;
  var htxt = TextEditingController();
  var ftxt = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkPermission();
    print("3456789");
  }

  void resetMeme() {
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());

      headerText = "";
      footerText = "";
      textColor = Colors.black;
      backgroundColor = Colors.amber;
      htxt.text = "";
      ftxt.text = "";
    });
  }

  Future<void> takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/meme${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    imgFile.writeAsBytes(pngBytes);
  }

  Future<void> _savefile(File file) async {
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result.substring(7));

    forwarding(result.substring(7), "Share Meme");
  }

  _askPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.photos,
      PermissionGroup.storage,
    ]);
    print(permissions);
  }

  _checkPermission() async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.requestPermissions([
      Permission.WRITE_EXTERNAL_STORAGE,
    ]);

    if (permission[Permission.WRITE_EXTERNAL_STORAGE] !=
        PermissionState.GRANTED) {
      _askPermission();
    }
  }

  void forwarding(String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewScreen(
          imageProvider: url,
          minScale: PhotoViewComputedScale.contained * 0.8,
          showTag: title,
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void changeTextColor(Color color) => setState(() => textColor = color);
  void changebackgroundColor(Color color) =>
      setState(() => backgroundColor = color);

  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Meme Generator"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Choose Colors ",
                style: Theme.of(context).textTheme.title,
              ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: htxt,
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
                  style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.w500),
                ),
              ),
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 220 + bottomSpace + upperSpace,
                      color: backgroundColor,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: upperSpace,
                          ),
                          Image.asset(
                            url,
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
                  controller: ftxt,
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
                  style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.w500),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      resetMeme();
                    }, padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 4
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      takeScreenshot();
                      setState(() {});
                    },
                    padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 4
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 530)
            ],
          ),
        ),
      ),
    );
  }
}
