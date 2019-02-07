import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './scoped-models/main.dart';
import './pages/name_list.dart';
import './pages/book_list.dart';
import './widgets/helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        // showPerformanceOverlay: true,
        title: 'Flutter NY Times Books',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/': (BuildContext context) => NameListPage(_model)},
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'names') {
            final String name = pathElements[2];
            return CustomRoute<bool>(
              builder: (BuildContext context) => BookListPage(_model, name),
            );
          }
          if (pathElements[1] == 'webview') {
            final String url = Uri.decodeComponent(pathElements[2]);
            return CustomRoute<bool>(
                builder: (BuildContext context) => WebviewScaffold(
                      url: url,
                      appBar: new AppBar(
                        title: const Text('Amazon shop'),
                      ),
                      withZoom: true,
                      withLocalStorage: true,
                      hidden: true,
                      initialChild: Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Text('Waiting.....'),
                        ),
                      ),
                    ));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => NameListPage(_model));
        },
      ),
    );
  }
}
