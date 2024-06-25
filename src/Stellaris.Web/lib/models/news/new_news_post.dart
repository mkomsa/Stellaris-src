// Define your model class to represent the data
class NewNewsPost {
  final String title;
  final String content;
  final String imageUrl;
  final String category;

  NewNewsPost({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
  });

  // Convert the model instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}
