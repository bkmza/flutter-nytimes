import 'dart:convert';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/name.dart';
import '../models/book.dart';
import '../shared/global_config.dart';

mixin ConnectedNamesModel on Model {
  List<Name> _names = [];
  List<Book> _books = [];
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

  List<Book> get allBooks {
    return List.from(_books);
  }

  void selectName(String name) {
    _selectedName = name;
    if (_selectedName != null) {
      notifyListeners();
    }
  }

  Future<Null> fetchNames() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('$baseURL/$getNamesEndpoint?api-key=$apiKey')
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

  Future<Null> fetchBooks(String selectedName) {
    _isLoading = true;
    notifyListeners();
    return http
        .get('$baseURL/$getListEndpoint?list=$selectedName&api-key=$apiKey')
        .then<Null>((http.Response response) {
      final List<Book> fetchedBooksList = [];
      final Map<String, dynamic> booksListData = json.decode(response.body);
      if (booksListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      booksListData.forEach((String key, dynamic data) {
        String amazonURL = '';
        if (key == 'results') {
          List<Map<String, dynamic>> resultList = List.from(data);
          resultList.forEach((item) {
            item.forEach((String itemKey, dynamic itemData) {
              if (itemKey == 'amazon_product_url') {
                amazonURL = itemData;
              }
              if (itemKey == 'book_details') {
                Map mapBookDetails = List<Map>.from(itemData)[0];
                final Book item = Book(
                    title: mapBookDetails['title'],
                    description: mapBookDetails['description'],
                    contributor: mapBookDetails['contributor'],
                    author: mapBookDetails['author'],
                    publisher: mapBookDetails['publisher'],
                    amazonURL: amazonURL);
                fetchedBooksList.add(item);
              }
            });
          });
        }
      });
      _books = fetchedBooksList;

      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
