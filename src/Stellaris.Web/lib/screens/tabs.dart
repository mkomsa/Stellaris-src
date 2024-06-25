import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellaris_app/data/sample_news.dart';
import 'package:stellaris_app/models/news/new_news_post.dart';
import 'package:stellaris_app/models/news/news_info.dart';
import 'package:stellaris_app/models/weather/weather_insight.dart';
import 'package:stellaris_app/screens/news/new_news.dart';
import 'package:stellaris_app/screens/news/news_screen.dart';
import 'package:stellaris_app/screens/weather/weather_screen.dart';
import 'package:stellaris_app/providers/weather_insight_provider.dart';
import 'package:http/http.dart' as http;

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _openAddNewsOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.95),
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.9),
            ],
            stops: const [0.1, 0.5, 0.9],
          ),
        ),
        child: NewNews(
          onAddNews: _addNews,
        ),
      ),
    );
  }

  Future<http.Response> createPost(NewNewsPost newNewsPost) async {
    final response = await http.post(
      Uri.parse('https://10.0.2.2:7014/api/space-news'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newNewsPost),
    );

    return response;
  }

  void _addNews(NewNewsPost newNewsPost) async {
    try {
      final response = await createPost(newNewsPost);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            content: Text(
              'Success! Please refresh this page in a minute',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            content:
                Text('Failed to create post. Error: ${response.reasonPhrase}'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          content: const Text('Whoops! Something went wrong!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    loadSpaceNews();
    Widget activePage = Consumer(
      builder: (context, ref, child) {
        AsyncValue<WeatherInsight> insight = ref.watch(weatherInsightProvider);

        return insight.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Center(
            child: Container(
              color: Colors.red.withOpacity(0.4),
              height: 128,
              child: Center(
                child: Text(
                  'Whoops! \n Make sure that you are online. \n This app needs internet connection in order to run.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          data: (weatherInsight) =>
              WeatherScreen(weatherInsight: weatherInsight),
        );
      },
    );

    if (_selectedTabIndex == 1) {
      activePage = NewsScreen(news: dummyNews);
    }

    return Scaffold(
      appBar: AppBar(
        title: _selectedTabIndex == 1
            ? Text(
                'Space NEWS',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              )
            : null,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.replay_outlined),
          onPressed: () {
            setState(() {
              ref.refresh(weatherInsightProvider).whenData((data) {});
              loadSpaceNews();
            });
          },
        ),
        actions: _selectedTabIndex == 1
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () {
                    _openAddNewsOverlay();
                  },
                ),
              ]
            : null,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: activePage,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          onTap: _selectTab,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTabIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: currentTheme.colorScheme.onSurface,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          iconSize: 24,
          elevation: 24,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloudy_snowing),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News',
            )
          ],
        ),
      ),
    );
  }
}
