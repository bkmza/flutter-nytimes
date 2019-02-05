import 'package:flutter/material.dart';

class Name {
  final String list_name;
  final String display_name;
  final String list_name_encoded;
  final String oldest_published_date;
  final String newest_published_date;
  final String updated;

  Name(
      {@required this.list_name,
      @required this.display_name,
      @required this.list_name_encoded,
      @required this.oldest_published_date,
      @required this.newest_published_date,
      @required this.updated});
}