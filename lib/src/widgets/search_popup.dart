import 'package:flutter/material.dart';

class SearchPopup extends StatefulWidget {
  final BuildContext homePageContext;

  /// Returns a Search popup dialog
  ///
  /// `homePageContext` a BuildContext
  SearchPopup(this.homePageContext);

  @override
  State<StatefulWidget> createState() {
    return _SearchPopupState(homePageContext);
  }
}

class _SearchPopupState extends State<SearchPopup> {
  final _searchKey = GlobalKey<FormState>();
  final BuildContext homePageContext;
  String _searchTerm;
  bool scanSuccess;
  final textFieldController = TextEditingController();
  var _isSearching = false;

  _SearchPopupState(this.homePageContext);

  @override
  Widget build(BuildContext context) {
    final _textColor = Colors.white;

    Widget _titleText = Text(
      'Enter a search term',
      style: TextStyle(
          color: _textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
    );

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
          }
          _searchTerm = value;
        },
        decoration: InputDecoration(labelText: 'Search Term'),
      ),
    );

    void _validateForm() {
      final searchForm = _searchKey.currentState;
      if (searchForm.validate()) {
        searchForm.save();
        Navigator.pop(context, _searchTerm);
      }
    }

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
          Navigator.pop(context);
        });

    _textFieldClear() {
      textFieldController.text = ' ';
      _searchKey.currentState.validate();
      textFieldController.clear();
    }

    Future<void> _showSearching(bool isScanning) async {
      setState(() {
        _isSearching = isScanning;
      });
      return await Future.delayed(Duration(milliseconds: 500));
    }

    Widget _okButton = FlatButton(
      child: Text(
        'OK',
        style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        {
          _validateForm();
        }
      },
    );

    return Dialog(
      child: Container(
        color: Colors.black,
        child: _isSearching == false
            ? Column(
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
                  Center(
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
                  ),
                ],
              )
            : Container(
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
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                ),
                height: 110.0,
              ),
      ),
    );
  }
}
