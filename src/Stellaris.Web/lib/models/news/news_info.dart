import 'package:flutter/material.dart';

class NewsInfo {
  const NewsInfo({
    required this.title,
    required this.content,
    required this.readTime,
    required this.imageUrl,
    required this.icon,
    required this.category,
  });

  final String title;
  final String content;
  final String readTime;
  final String imageUrl;
  final IconData icon;
  final String category;

  factory NewsInfo.fromJson(Map<String, dynamic> json) {
    return NewsInfo(
        title: json['title'] as String,
        content: json['content'] as String,
        readTime: json['readTime'] as String,
        icon: Icons.explore,
        imageUrl: json['imageUrl'] as String,
        category: json['category'] as String);
  }
}

enum NewsCategory {
  science,
  exploration,
  tech,
  environment,
  colonization,
  astronomy,
  culture,
  education,
}
