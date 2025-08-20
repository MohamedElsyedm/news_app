import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/constants/constants_text.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:news_app/news/news_item.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatefulWidget {
  NewsBottomSheet(this.newsItem);

  News newsItem;

  @override
  State<NewsBottomSheet> createState() => _NewsBottomSheetState();
}

class _NewsBottomSheetState extends State<NewsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(widget.newsItem.url!);
    Future<void>? _launched;

    Future<void> _launchInAppWithBrowserOptions(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
        browserConfiguration: const BrowserConfiguration(showTitle: true),
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      margin: EdgeInsets.all(16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppTheme.black,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(
              widget.newsItem.urlToImage ??
                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.newsItem.title!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
            ),
            onPressed: () {
              setState(() {
                _launched = _launchInAppWithBrowserOptions(_url);
              });
            },
            child: Text(ConstantsText.viewFullArticle),
          ),
        ],
      ),
    );
  }
}
