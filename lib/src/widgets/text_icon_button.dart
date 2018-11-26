import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  TextIconButton({this.title, this.onPressed, this.icon});
  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 1.0, color: Theme.of(context).accentColor),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.body1.fontSize,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Icon(icon, color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
