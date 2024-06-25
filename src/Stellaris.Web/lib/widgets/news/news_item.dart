import 'package:flutter/material.dart';
import 'package:stellaris_app/models/news/news_info.dart';
import 'package:stellaris_app/widgets/news/news_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    required this.news,
    required this.onSelectNews,
    super.key,
  });

  final NewsInfo news;
  final void Function(NewsInfo newsInfo) onSelectNews;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 16,
      child: InkWell(
        onTap: () {
          onSelectNews(news);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(news.imageUrl),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                );
              },
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.6),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NewsItemTrait(
                          icon: Icons.schedule,
                          label: '${news.readTime} min',
                        ),
                        const SizedBox(width: 32),
                        NewsItemTrait(
                          icon: news.icon,
                          label: news.category,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
