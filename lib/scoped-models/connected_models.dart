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
  List<Name> get allNames {
    return List.from(_names);
  }

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
        if (key == 'results') {
          Set<dynamic> set = Set.from(data);
          set.forEach((nameData) {
            final Name item = Name(
                listName: nameData['list_name'],
                displayName: nameData['display_name'],
                listNameEncoded: nameData['list_name_encoded'],
                oldestPublishedDate: nameData['oldest_published_date'],
                newestPublishedDate: nameData['newest_published_date'],
                updated: nameData['updated']);
            fetchedNamesList.add(item);
          });
        }
      });
      _names = fetchedNamesList;

      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
