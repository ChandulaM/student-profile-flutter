import 'package:flutter/material.dart';

class AppPageLayout extends StatefulWidget {

  final Widget body;
  final VoidCallback? onBackPress;

  const AppPageLayout({Key? key, required this.body, this.onBackPress}) : super(key: key);

  @override
  _AppPageLayoutState createState() => _AppPageLayoutState();
}

class _AppPageLayoutState extends State<AppPageLayout> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: width*0.15, right: width*0.15),
        child: SingleChildScrollView(
          child: widget.body,
        ),
      ),
      appBar: AppBar(
        leading: widget.onBackPress != null ? IconButton(
            onPressed: widget.onBackPress,
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)
        ) : Container(),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text("sd"),
      ),
    );
  }
}
