import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_extend/share_extend.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.showTag,
  });

  // final ImageProvider imageProvider;
  final String imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String showTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(showTag),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareMeme(imageProvider);
            },
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: FileImage(File(imageProvider)),
          loadingBuilder: loadingBuilder,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: PhotoViewHeroAttributes(tag: showTag),
          enableRotation: true,
        ),
      ),
    );
  }

  Future<void> _shareMeme(String imageProvider) async {
    ShareExtend.share(imageProvider, "My Meme");
  }
}