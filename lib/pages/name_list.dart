import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../widgets/names.dart';

class NameListPage extends StatefulWidget {
  final MainModel model;

  NameListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _NameListPageState();
  }
}

class _NameListPageState extends State<NameListPage> {
  @override
  initState() {
    widget.model.fetchNames();
    super.initState();
  }

  Widget _buildNamesList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, MainModel model) {
        Widget content = Center(child: Text('No items found.'));
        if (model.allNames.length > 0 && !model.isLoading) {
          content = Names();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: model.fetchNames,
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NY Times Books'),
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
      body: _buildNamesList(),
    );
  }
}
