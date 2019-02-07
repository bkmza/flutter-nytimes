import 'package:flutter/material.dart';

class Book {
  final String title;
  final String description;
  final String contributor;
  final String author;
  final String publisher;

  Book(
      {@required this.title,
      @required this.description,
      @required this.contributor,
      @required this.author,
      @required this.publisher});
}