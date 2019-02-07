import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/name.dart';
import '../scoped-models/main.dart';
import '../widgets/name_card.dart';

class Names extends StatelessWidget {
  Widget _buildNameList(List<Name> names, Function selectName) {
    Widget nameCard;

    if (names.length > 0) {
      nameCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
              onTap: () {
                String selectedName = names[index].listNameEncoded;
                selectName(selectedName);
                Navigator.pushNamed<bool>(context, '/names/' + selectedName)
                      .then((_) => selectName(null));
              },
              child: NameCard(names[index]));
        },
        itemCount: names.length,
      );
    } else {
      nameCard = Center(
        child: Text('No names found, something went wrong'),
      );
    }
    return nameCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildNameList(model.allNames, model.selectName);
      },
    );
  }
}
