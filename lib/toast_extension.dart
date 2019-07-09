import 'package:flutter/material.dart';

toast(BuildContext context, String message, [int duration = 2]) {
    var overlayEntry = OverlayEntry(builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.9,
        child: Material(
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Center(
                    child: Card(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(message,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                            ),
                        ),
                        color: Colors.grey.shade800,
                    ),
                ),
            ),
        ))
    );
    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: duration)).then((value) {
        overlayEntry.remove();
    });
}
