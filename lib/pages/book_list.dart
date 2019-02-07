import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../widgets/books.dart';
import '../models/name.dart';

class BookListPage extends StatefulWidget {
  final MainModel model;
  final String selectedName;

  BookListPage(this.model, this.selectedName);

  @override
  State<StatefulWidget> createState() {
    return _BookListPageState();
  }
}

class _BookListPageState extends State<BookListPage> {
  @override
  initState() {
    widget.model.fetchBooks(widget.selectedName);
    super.initState();
  }

  Widget _buildBooksList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, MainModel model) {
        Widget content = Center(child: Text('No books found.'));
        if (model.allNames.length > 0 && !model.isLoading) {
          content = Books();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return content;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.allNames.firstWhere((Name item) {
          return item.listNameEncoded == widget.selectedName;
        }).displayName),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget widget, MainModel model) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: model.fetchNames,
              );
            },
          )
        ],
      ),
      body: _buildBooksList(),
    );
  }
}
