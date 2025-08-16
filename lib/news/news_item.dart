import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now().subtract(Duration(minutes: 20));
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
            child: Image.asset(
              'assets/images/news.png',
              height: MediaQuery.sizeOf(context).height * 0.24,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '40-year-old man falls 200 feet to his death while canyoneering at national park',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By : Jon Haworth', style: textTheme.labelSmall),
              Text(timeago.format(dateTime), style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
