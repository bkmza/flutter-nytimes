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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildTitleRow(),
          Divider(color: Colors.grey, indent: 15.0),
          DescriptionDefault(book.description),
          SizedBox(height: 5.0),
          _buildIconTagRow(Icons.account_circle, book.author),
          _buildIconTagRow(Icons.verified_user, book.publisher),
          _buildIconTagRow(Icons.account_balance, book.contributor)
        ],
      ),
    );
  }
}
