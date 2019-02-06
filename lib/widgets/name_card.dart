import 'package:flutter/material.dart';

import '../models/name.dart';
import '../widgets/ui_elements/title_default.dart';
import '../widgets/ui_elements/tag_default.dart';

class NameCard extends StatelessWidget {
  final Name name;

  NameCard(this.name);

  Widget _buildTitleRow() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: TitleDefault(name.displayName),
            ),
          ],
        ));
  }

  Widget _buildTagsRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          TagDefault(name.oldestPublishedDate),
          SizedBox(
            width: 10.0,
          ),
          TagDefault(name.newestPublishedDate)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildTitleRow(),
          SizedBox(
            height: 5.0,
          ),
          _buildTagsRow(),
        ],
      ),
    );
  }
}
