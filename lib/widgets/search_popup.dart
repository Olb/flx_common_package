library flx_common_package;

import 'package:flutter/material.dart';

class SearchPopupWidget extends StatefulWidget {
  @override
  _SearchPopupWidgetState createState() => _SearchPopupWidgetState();
}

class _SearchPopupWidgetState extends State<SearchPopupWidget> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Search for a barcode or product name.',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: TextField(
                      controller: _textController,
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                      decoration: InputDecoration(
                        labelText: 'Product name or barcode',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                      iconSize: 40.0,
                      icon: Image.asset(
                        'im/barcode-scan.png',
                        scale: 0.01,
                      ),
                      onPressed: () async {
                        String result = '';//await BarcodeScanner.scanImage();
                        if (result == null) {
                          // deal with this later
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.mic,
                      color: Colors.white,
                    ),
                    onPressed: () => print("mic pressed"),
                  ),
                  Expanded(
                    child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          _textController.clear();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
