import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:path_provider/path_provider.dart';

import 'package:zhihu_daily_flutter/ApiRequest/api_requester.dart';
import 'package:zhihu_daily_flutter/Model/story.dart';
import 'package:zhihu_daily_flutter/Model/news_detail.dart';

class NewsDetailPage extends StatefulWidget {

  final Story story;


  NewsDetailPage({@required this.story});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {

  NewsDetail _newsDetail;
  String _htmlUrl;
  String _htmlString;

  final fileName = 'news_detail.html';

  @override
  void initState() {
    super.initState();

    _getNewsDetail();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: _buildWebView(),
    );
  }

  Widget _buildWebView() {

    if (_newsDetail == null) {
      return Container();
    }
    if (_htmlString == null) {
      return InAppWebView(initialUrl: _newsDetail.share_url,);
    }

    return Stack(
      children: <Widget>[
        InAppWebView(
          initialData: InAppWebViewInitialData(_htmlString),
        ),

      ],
    );

  }


  _getNewsDetail() async {
    try {
      final newsDetail = await ApiRequester.instance.getNewsDetail(widget.story.id);

      _newsDetail = newsDetail;
      if (newsDetail.body != null) {
        final headImageString = '''
        <div class="img-wrap">
        <h1 class="headline-title">${newsDetail.title}</h1>
        <span class="img-source">${newsDetail.image_source}</span>
        <img src=${newsDetail.image} alt="">
        <div class="img-mask"></div>
        </div>
        ''';
        final body = newsDetail.body.replaceAll('<div class="img-place-holder"></div>', headImageString);
        final htmlString = '''
      <html>
      <head>
      <meta name="viewport" content="initial-scale=1.0, maximum-scale=1, minimum-scale=1, user-scalable=no,uc-fitscreen=yes">
      <link rel="stylesheet" href="${newsDetail.css.first}">
      <style>
      .img-wrap {
  position: relative;
  max-height: 260px;
  overflow: hidden;
}
.img-wrap img {
  margin-top: -18%;
  width: 640px;
}
.img-wrap .img-source {
  position: absolute;
  bottom: 10px;
  z-index: 1;
  font-size: 12px;
  color: rgba(255,255,255,.6);
  right: 40px;
  text-shadow: 0px 1px 2px rgba(0,0,0,.3);
}
.img-mask {
  position: absolute;
  top:0;
  width: 100%;
  height: 100%;
  background: -moz-linear-gradient(top, rgba(0,0,0,0) 25%, rgba(0,0,0,0.6) 100%); /* FF3.6+ */
  background: -webkit-gradient(linear, left top, left bottom, color-stop(25%,rgba(0,0,0,0)), color-stop(100%,rgba(0,0,0,0.6))); /* Chrome,Safari4+ */
  background: -webkit-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%); /* Chrome10+,Safari5.1+ */
  background: -o-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%); /* Opera 11.10+ */
  background: -ms-linear-gradient(top, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%); /* IE10+ */
  background: linear-gradient(to bottom, rgba(0,0,0,0) 25%,rgba(0,0,0,0.6) 100%); /* W3C */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00000000', endColorstr='#99000000',GradientType=0 ); /* IE6-9 */
}
.headline-title {
  margin: 20px 0 10px;
  font-size: 24px;
  line-height: 1.2em;
  padding: 0 40px;
  color: #222;
}
.img-wrap .headline-title {
  margin: 20px 0;
  bottom: 10px;
  z-index: 1;
  position: absolute;
  color: white;
  text-shadow: 0px 1px 2px rgba(0,0,0,0.3);
}
      </style>
      </head>
      <body>
      $body
      </body>
      </html>
      ''';
        _htmlString = htmlString;
      }
      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }


  Future<File> _getLocalHtmlFile() async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/$fileName');
  }

  void _writeHtmlFile(String htmlString) async {
    final file = await _getLocalHtmlFile();
    final afterFile = await file.writeAsString(htmlString);
    setState(() {
      _htmlUrl = afterFile.uri.toString();
    });
    print(_htmlUrl);
    print(_newsDetail.share_url);
    print(_htmlString);
  }
}