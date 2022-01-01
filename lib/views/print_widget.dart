import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muznotes/controllers/page_controller.dart';
import 'package:muznotes/utils/painter.dart';
import 'package:muznotes/views/line_view.dart';

class PrintWidget extends StatefulWidget {
  final PainterController painterController;
  const PrintWidget({Key? key, required this.painterController})
      : super(key: key);

  @override
  State<PrintWidget> createState() => _PrintWidgetState();
}

class _PrintWidgetState extends State<PrintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ListView(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20.0),
                      children: const <Widget>[
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                        FiveLineWidget(),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.41,
                      height: MediaQuery.of(context).size.height,
                      child: Painter(widget.painterController),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
