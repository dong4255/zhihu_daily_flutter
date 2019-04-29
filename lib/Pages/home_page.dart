import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:zhihu_daily_flutter/Model/news.dart';
import 'package:zhihu_daily_flutter/Model/story.dart';
import 'package:zhihu_daily_flutter/ApiRequest/api_requester.dart';
import 'package:zhihu_daily_flutter/Widgets/home_row_item.dart';
import 'news_detail_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _title = '今日热闻';
  var _topStoryList = <Story>[];
  final _swiperController = SwiperController();
  var _dataList = List();
  var _latestDate = '';

  var _isRefreshing = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    _isRefreshing = true;
    _refreshNewsData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(),
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
              accountName: Text("xxx"),
              accountEmail: Text("xxxxxxx@xxx.com"),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(240, 240, 240, 1),
        child: RefreshIndicator(
          onRefresh: _refreshNewsData,
          child: NotificationListener(
            onNotification: (notification) {
              _handleScrollNotification(notification);
            },
            child: ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: _buildRowItem,
            ),
          ),
        ),
      ),
    );
  }
  

  /*
  * 创建Banner
  * */
  Widget _buildBanner() {
    return Container(
      height: 240,
      child: _topStoryList.length == 0
      ? null
      : Swiper(
        autoplay: true,
        autoplayDelay: 5000,
        autoplayDisableOnInteraction: true,
        controller: _swiperController,
        pagination: SwiperPagination(),
        itemCount: _topStoryList.length,
        itemBuilder: (context, index) {
          final story = _topStoryList[index];
          return GestureDetector(
            onTap: () {
              print(story.id);
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(story: story)));
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(story.image, fit: BoxFit.fitWidth,),
                Positioned(
                  left: 12, right: 12, bottom: 30,
                  child: Text(
                    story.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /*
  * 创建每行视图
  * */
  Widget _buildRowItem(BuildContext context, int index) {
    if (index == 0) {
      return _buildBanner();
    }
    if (_dataList[index] is String) {
      return Container(
        padding: EdgeInsets.only(left: 10,top: 16,bottom: 16,right: 10),
        child: Text(
          _dataList[index],
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    }
    if (_dataList[index] is Story) {
      final Story story = _dataList[index];
      return HomeRowItem(
        story: story,
        onTap: () {
          print(story.id);
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(story: story)));
        },
      );
    }

    return null;
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.extentAfter <= 150 && !_isLoading && !_isRefreshing) {
      _loadMoreData();
    }
  }

  /*
  * 刷新数据
  * */
  Future<Null> _refreshNewsData() async {
    _isRefreshing = true;
    try {
      final news = await ApiRequester.instance.getLatestNews();
      if (news.top_stories != null && news.stories != null) {
        _topStoryList.clear();
        _topStoryList = news.top_stories;

        _dataList.clear();
        _dataList.add('今日热闻');
        _dataList.add(news.date);
        _latestDate = news.date;
        _dataList.addAll(news.stories);

        setState(() {
          _isRefreshing = false;
        });
      }
    }catch (e) {
      print(e);
      _isRefreshing = false;
    }
  }

  /*
  * 加载更多数据
  * */
  void _loadMoreData() async {
    _isLoading = true;
    try {
      final news = await ApiRequester.instance.getBeforeNews(_latestDate);
      if (news.stories != null) {
        _dataList.add(news.date);
        _latestDate = news.date;
        _dataList.addAll(news.stories);

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      _isLoading = false;
    }
  }
}