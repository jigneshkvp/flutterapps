class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class PostList {
  List<Post> posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = List<Post>();

    parsedJson.forEach((element) {
      posts.add(Post.fromJson(element));
    });

    return PostList(posts: posts);
  }
}
