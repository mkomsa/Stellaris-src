import 'package:flutter/material.dart';
import 'package:stellaris_app/models/news/news_info.dart';
import 'package:stellaris_app/widgets/news/news_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({required this.newsInfo, super.key});

  final NewsInfo newsInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          newsInfo.category,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(newsInfo.imageUrl),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
          Positioned.fill(
            top: kToolbarHeight * 2,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(200, 230, 95, 95),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withOpacity(0.9),
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(1),
                        Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withOpacity(0.9),
                      ],
                      stops: const [0.1, 0.5, 0.9],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    newsInfo.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withOpacity(0.7),
                        Theme.of(context)
                            .colorScheme
                            .errorContainer
                            .withOpacity(0.8),
                        Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withOpacity(0.7),
                      ],
                      stops: const [0.2, 0.5, 0.8],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: NewsItemTrait(
                    icon: Icons.schedule,
                    label: '${newsInfo.readTime} min',
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 32, bottom: kToolbarHeight),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primaryContainer,
                          Theme.of(context).colorScheme.secondaryContainer,
                        ],
                        stops: const [0.2, 0.6],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.9),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            width: 0.5),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        newsInfo.content,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
