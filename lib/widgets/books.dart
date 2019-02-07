import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/book.dart';
import '../scoped-models/main.dart';
import '../widgets/book_card.dart';

class Books extends StatelessWidget {
  Widget _buildBookList(List<Book> books, Function selectBook) {
    Widget card;

    if (books.length > 0) {
      card = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
              onTap: () {
                // String selectedName = books[index].listNameEncoded;
                // selectName(selectedName);
                // Navigator.pushNamed<bool>(context, '/names/' + selectedName)
                //       .then((_) => selectName(null));
              },
              child: BookCard(books[index]));
        },
        itemCount: books.length,
      );
    } else {
      card = Center(
        child: Text('No names found, something went wrong'),
      );
    }
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildBookList(model.allBooks, model.selectName);
      },
    );
  }
}
