import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  NewsItem(this.news);

  News news;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.white),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(
              news.urlToImage ??
                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
              height: MediaQuery.sizeOf(context).height * 0.24,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(news.title!, style: textTheme.titleMedium),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By: ${news.source?.name}', style: textTheme.labelSmall),
              Text(
                timeago.format(news.publishedAt!),
                style: textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
