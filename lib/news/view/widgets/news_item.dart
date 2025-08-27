import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/shared/app_theme.dart';
import 'package:news_app/shared/constants/constants_text.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/shared/settings_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  NewsItem(this.news, {super.key});

  News news;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: SettingsProvider().themeMode == ThemeMode.dark
              ? AppTheme.white
              : AppTheme.black,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(
              news.urlToImage ?? ConstantsText.emptyImage,
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
              Text(
                '${AppLocalizations.of(context)!.by} ${news.source?.name}',
                style: textTheme.labelSmall,
              ),
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
