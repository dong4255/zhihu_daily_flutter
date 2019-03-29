import 'package:flutter/material.dart';

import 'package:zhihu_daily_flutter/Model/story.dart';

class HomeRowItem extends StatelessWidget {

  final Story story;
  final VoidCallback onTap;

  HomeRowItem({@required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        child: Card(
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      story.title,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  _buildImage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (story.images == null || story.images.isEmpty) {
      return null;
    }

    return Container(
      padding: EdgeInsets.only(left: 10),
      width: 100,
      height: 80,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(story.images.first, fit: BoxFit.cover,),
          story.multipic != null ?
          Positioned(
            right: 3, bottom: 2,
            child: Container(
              color: Colors.black38,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Icon(Icons.filter_none, color: Colors.white, size: 12,),
                  ),
                  Text(
                    '多图',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          )
          : Container(),
        ],
      ),
    );
  }
}