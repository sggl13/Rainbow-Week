import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/widgets/task.dart';
import '../models/article_model.dart';
import '../providers/task_provider.dart';
import '../services/news_api.dart';
import 'article_object.dart';

class NewsList extends StatelessWidget {

  late Future<List<Article>> _futureArticles;

  NewsList({super.key}) {
    _futureArticles = ApiService().getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          print(snapshot);
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if(!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found'));
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ArticleObject(snapshot.data![index], context);
                }
            );
          }
        }
    );
  }

}