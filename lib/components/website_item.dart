import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/models/website_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteItem extends StatefulWidget {
  final int category;
  final String url;
  const WebsiteItem({
    super.key,
    required this.category,
    required this.url,
  });

  @override
  State<WebsiteItem> createState() => _WebsiteItemState();
}

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    throw Exception('Não foi possivel abrir o site $url');
  }
}

class _WebsiteItemState extends State<WebsiteItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _launchUrl(widget.url);
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: CachedNetworkImage(
              imageUrl: WebsiteFormatter.getLogo(widget.category),
              placeholder: (context, url) => CircularProgressIndicator(),
              width: 50,
              height: 50,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _launchUrl(widget.url);
          },
          child: Text(
            WebsiteFormatter.getName(widget.category),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
