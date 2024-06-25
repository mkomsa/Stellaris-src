import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stellaris_app/models/news/news_info.dart';
import 'package:stellaris_app/screens/news/news_details.dart';
import 'package:stellaris_app/widgets/news/news_item.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({required this.news, super.key});

  final List<NewsInfo> news;

  void selectNews(BuildContext context, NewsInfo newsInfo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewsDetails(newsInfo: newsInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.15, 0.55, 0.7, 0.85],
                colors: [
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  Theme.of(context).colorScheme.onBackground,
                  Theme.of(context).colorScheme.onSecondary.withOpacity(0.9),
                  Theme.of(context)
                      .colorScheme
                      .onSecondaryContainer
                      .withOpacity(0.6),
                ],
              ).createShader(bounds);
            },
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2),
              child: Image.asset(
                'assets/news_screen_background.jpg',
                fit: BoxFit.cover,
                height: deviceHeight,
                width: deviceWidth,
              ),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.11,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              clipBehavior: Clip.hardEdge,
              itemCount: news.length,
              itemBuilder: (ctx, index) => NewsItem(
                news: news[index],
                onSelectNews: ((newsInfo) {
                  selectNews(context, newsInfo);
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
