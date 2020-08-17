import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:my_app/model/post.dart';

class Network {
  final String url;

  Network(this.url);

  Future getData() async {
    print("$url");

    Response res = await get(Uri.encodeFull(url));

    if (res.statusCode == 200)
      return json.decode(res.body);
    else
      return "$res.statusCode";
  }

  Future<PostList> getAllPosts() async {
    final res = await get(Uri.encodeFull(url));

    if (res.statusCode == 200)
      return PostList.fromJson(json.decode(res.body));
    else
      throw HttpException("Failed to get posts");
  }
}
