import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';
import 'dart:async';

/// Popup for searching training and products
///
/// `user` User
/// `api` Api
class SearchPopup extends StatefulWidget {
  final User user;
  final Api api;
  /// Returns a Search popup dialog
  ///
  /// `user` User
  /// `api` Api
  SearchPopup(this.user, this.api);

  @override
  State<StatefulWidget> createState() {
    return _SearchPopupState(user, api);
  }
}

class _SearchPopupState extends State<SearchPopup> {
  final _searchKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();
  final User user;
  final _textColor = Colors.white;
  final Api api;
  String _searchTerm;
  Stream<SearchBloc> stream;
  StreamSubscription _searchSubscription;

  _SearchPopupState(this.user, this.api);

  void _onData(TrainingList training) {
    if (training.trainingList.isEmpty) {
      textFieldController.text = 'no results found';
      _searchKey.currentState.validate();
    } else {
      _validateForm(training);
    }
  }

  void _validateForm(TrainingList training) async {
    final searchForm = _searchKey.currentState;
    if (searchForm.validate()) {
      searchForm.save();
      Navigator.pop(context, training);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = SearchBloc(api);

    _searchSubscription = searchBloc.searchResult.listen(_onData);

    Widget _titleText = Text(
      'Enter a search term',
      style: TextStyle(
          color: _textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
    );

    _textFieldClear() {
      textFieldController.text = ' ';
      _searchKey.currentState.validate();
      textFieldController.clear();
    }

    Widget _formTextField = Form(
      key: _searchKey,
      child: TextFormField(
        autofocus: true,
        autocorrect: false,
        textAlign: TextAlign.center,
        controller: textFieldController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Search term cannot be blank';
          } else if (value == 'no results found') {
            _textFieldClear();
            return 'No results found - try again.';
          }
          _searchTerm = value;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(labelText: 'Search Term or Barcode'),
      ),
    );

    Widget _micButton = IconButton(
        icon: Icon(
          Icons.mic,
          color: Colors.white,
        ),
        onPressed: () => print('Not implemented'));

    Widget _cancelButton = FlatButton(
        child: Text(
          'Cancel',
          style: TextStyle(
            color: _textColor,
          ),
        ),
        onPressed: () {
          Navigator.pop(context, null);
        });

    Widget _okButton = FlatButton(
      child: Text(
        'OK',
        style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        {
          if (!(_searchKey.currentState.validate())) {
            return;
          }
          searchBloc.addSearchTerm.add(_searchTerm);
        }
      },
    );

    return Dialog(
      child: SearchProvider(
        searchBloc: searchBloc,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _titleText,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(primaryColor: _textColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _formTextField,
                    ),
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: searchBloc.loading,
                    builder: (ctx, snapshot) {
                      if (!snapshot.data) {
                        return Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: _cancelButton,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: _micButton,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: _okButton,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        height: 0,
                      );
                    },
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: searchBloc.loading,
              initialData: false,
              builder: (ctx, snapshot) {
                if (!snapshot.data) {
                  return Container(
                    height: 0,
                  );
                }
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Searching',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: _textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  height: 110.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchSubscription.cancel();
    super.dispose();
  }
}
