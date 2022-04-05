import 'package:flutter/material.dart';
import 'package:student_profile/common/text_styles.dart';

class AppPageLayout extends StatefulWidget {

  final Widget body;
  final VoidCallback? onBackPress;
  final VoidCallback? onDonePress;
  final String? title;

  const AppPageLayout({Key? key, required this.body, this.onBackPress, this.title, this.onDonePress}) : super(key: key);

  @override
  _AppPageLayoutState createState() => _AppPageLayoutState();
}

class _AppPageLayoutState extends State<AppPageLayout> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20, left: width*0.15, right: width*0.15),
          child: widget.body,
        ),
        appBar: AppBar(
          leading: widget.onBackPress != null ? IconButton(
              onPressed: widget.onBackPress,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)
          ) : Container(),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: widget.title!=null ? Text(widget.title??"", style: TextStyles.blackTextStyle14pt,) : Container(),
          elevation: 0,
          actions: [
            if(widget.onDonePress!=null) IconButton(
                onPressed: widget.onDonePress,
                icon: const Icon(Icons.done, color: Colors.black,)),
          ],
          centerTitle: true,
        ),
      ),
    );
  }
}
