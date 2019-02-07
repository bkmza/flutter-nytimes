import 'package:flutter/material.dart';

import '../models/book.dart';
import '../widgets/ui_elements/title_default.dart';
import '../widgets/ui_elements/tag_default.dart';
import '../widgets/ui_elements/description_default.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard(this.book);

  Widget _buildTitleRow() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: TitleDefault(book.title),
            ),
          ],
        ));
  }

  Widget _buildIconTagRow(IconData icon, String text) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          children: <Widget>[Icon(icon), SizedBox(width: 5), TagDefault(text)],
        ));
  }

  Widget _buildBuyBookRow(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.attach_money),
          onPressed: () {
            Navigator.pushNamed<bool>(
                context, '/webview/' + Uri.encodeComponent(book.amazonURL));
          },
        ),
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            Navigator.pushNamed<bool>(context, '/webview/' + book.amazonURL);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildTitleRow(),
          Divider(color: Colors.grey, indent: 15.0),
          FadeInImage(
            height: 250.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/default_image.png'),
            image: NetworkImage(''),
          ),
          DescriptionDefault(book.description),
          SizedBox(height: 5.0),
          _buildIconTagRow(Icons.account_circle, book.author),
          _buildIconTagRow(Icons.verified_user, book.publisher),
          _buildIconTagRow(Icons.account_balance, book.contributor),
          _buildBuyBookRow(context)
        ],
      ),
    );
  }
}
