import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=23ee5a6fcc3a42d69aa497cc2668e2d2';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'ok') {
        setState(() {
          articles = List<Map<String, dynamic>>.from(responseData['articles']);
        });
      } else {
        print('Error: Response status is not ok');
      }
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Page'),
        backgroundColor: Color(0xffffa5a5),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(article['title'] ?? ''),
              subtitle: Text(article['description'] ?? ''),
              leading: article['urlToImage'] != null
                  ? SizedBox(
                width: 120.0,
                height: 150.0,
                child: Image.network(
                  article['urlToImage'] ?? '',
                  fit: BoxFit.cover,
                ),
              ): Container(
                width: 120.0,
                height: 150.0,
                color: Colors.grey,
              ),
              onTap: () {
                // Handle news item tap
                _launchURL(article['url']);
              },
            ),
          );
        },
      ),
    );
  }

  void launchUrl(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
