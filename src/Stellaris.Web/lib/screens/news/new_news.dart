import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:stellaris_app/models/news/new_news_post.dart';

class NewNews extends StatefulWidget {
  const NewNews({required this.onAddNews, super.key});

  final void Function(NewNewsPost newNewsPost) onAddNews;

  @override
  State<StatefulWidget> createState() {
    return _NewNewsState();
  }
}

class _NewNewsState extends State<NewNews> {
  final List<String> categories = [
    "science",
    "exploration",
    "tech",
    "environment",
    "colonization",
    "astronomy",
    "culture",
    "education",
  ];

  void _submitNewNews() {
    bool enteredTitle = _titleController.text.trim().isEmpty;
    bool validUrl = false;

    if (_imageUrlController.text.trim().isNotEmpty) {
      Uri? parsedUri = Uri.tryParse(_imageUrlController.text.trim());

      if (parsedUri != null) {
        validUrl = true;
      }
    }

    if (enteredTitle || !validUrl) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title and image URL was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddNews(
      NewNewsPost(
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageUrlController.text,
        category: "",
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  var _category = 'science';

  @override
  Widget build(BuildContext context) {
    var labelTextColor = Theme.of(context).colorScheme.onSecondaryContainer;
    var inputTextColor = Theme.of(context).colorScheme.onSecondaryContainer;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Create a new post',
          style: TextStyle(
            color: labelTextColor,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.only(
              top: kToolbarHeight,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(
                        color: inputTextColor,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        labelText: "Title",
                        labelStyle: TextStyle(color: labelTextColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: _contentController,
                          maxLines: null, // Allows for unlimited lines
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            labelText: "Content",
                            labelStyle: TextStyle(color: labelTextColor),
                            hintText: 'Enter your text here...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _imageUrlController,
                      style: TextStyle(
                        color: inputTextColor,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        labelText: "Image URL",
                        labelStyle: TextStyle(color: labelTextColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    child: SingleChildScrollView(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: labelTextColor),
                          border: const UnderlineInputBorder(), // Custom border
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        value: _category,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _category = value!;
                        },
                        style: TextStyle(
                          color: inputTextColor,
                        ), // Custom text style
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ), // Custom dropdown icon
                        iconSize: 24, // Custom icon size
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 24,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _submitNewNews();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withOpacity(0.99),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          shadows: [
                            Shadow(
                              color: Theme.of(context).colorScheme.onPrimary,
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
