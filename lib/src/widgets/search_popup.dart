import 'package:flutter/material.dart';
import 'package:flx_common_package/common.dart';


/// Popup for searching training and products
///
/// `homePageContext` BuildContext
/// `user` User
/// `api` Api
class SearchPopup extends StatefulWidget {
  final BuildContext homePageContext;
  final User user;
  final Api api;

  /// Returns a Search popup dialog
  ///
  /// `homePageContext` a BuildContext
  SearchPopup(this.homePageContext, this.user, this.api);

  @override
  State<StatefulWidget> createState() {
    return _SearchPopupState(homePageContext, api, user);
  }
}

class _SearchPopupState extends State<SearchPopup> {
  final _searchKey = GlobalKey<FormState>();
  final BuildContext _homePageContext;
  String _searchTerm;
  bool scanSuccess;
  final textFieldController = TextEditingController();
  var _isSearching = false;
  final Api api;
  final User user;

  _SearchPopupState(this._homePageContext, this.api, this.user);

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
          } else if (value == 'empty') {
            return 'No Results found';
          }
          _searchTerm = value;
        },
        style: TextStyle(color: Colors.white),
        decoration: _searchTerm == 'empty' ? InputDecoration(labelText: 'Search Term', errorText: 'Try again') : InputDecoration(labelText: 'Search Term'),
      ),
    );

    Future<dynamic> _performSearch() async {
      setState(() {
        _isSearching = true;
      });
      final products = await api.getProducts(user, _searchTerm) as TrainingList;
      setState(() {
        _isSearching = false;
      });
      if (products == null || products.trainingList.isEmpty) {
        return null;
      }
    }

    void _validateForm() async {
      final searchForm = _searchKey.currentState;
      if (searchForm.validate()) {
        final training = await _performSearch() as TrainingList;
        if (training == null || training.trainingList.isEmpty) {
          textFieldController.text = 'empty';
          searchForm.validate();
          return;
        }
        searchForm.save();
        Navigator.pop(context, training);
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
          Navigator.pop(context, null);
        });

    _textFieldClear() {
      textFieldController.text = ' ';
      _searchKey.currentState.validate();
      textFieldController.clear();
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
                        child: CircularProgressIndicator(backgroundColor: Colors.white,),
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
