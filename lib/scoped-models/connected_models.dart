import 'dart:convert';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/name.dart';

mixin ConnectedNamesModel on Model {
  List<Name> _names = [];
  String _selectedName;
  bool _isLoading = false;
}

mixin UtilityModel on ConnectedNamesModel {
  bool get isLoading {
    return _isLoading;
  }
}

mixin NamesModel on ConnectedNamesModel {
  Future<Null> fetchNames() {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=lb5w982Gf0A7wdyr3mB76lPEmIYBZTiY')
        .then<Null>((http.Response response) {
      final List<Name> fetchedNamesList = [];
      final Map<String, dynamic> namesListData = json.decode(response.body);
      if (namesListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      namesListData.forEach((String key, dynamic data) {
        Set<String> set = Set.from(data['results']);
        set.forEach((element) => print(element));
      });

      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
