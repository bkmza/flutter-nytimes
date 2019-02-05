import 'package:flutter/material.dart';

class Name {
  final String listName;
  final String displayName;
  final String listNameEncoded;
  final String oldestPublishedDate;
  final String newestPublishedDate;
  final String updated;

  Name(
      {@required this.listName,
      @required this.displayName,
      @required this.listNameEncoded,
      @required this.oldestPublishedDate,
      @required this.newestPublishedDate,
      @required this.updated});
}