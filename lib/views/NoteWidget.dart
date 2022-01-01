import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muznotes/controllers/page_controller.dart';
import 'package:muznotes/controllers/scroll_controller.dart';
import 'package:muznotes/utils/painter.dart';
import 'package:muznotes/views/line_view.dart';
import 'package:muznotes/views/pen_erase_button.dart';

class NoteWidget extends StatefulWidget {
  final PainterController painterController;
  const NoteWidget({Key? key, required this.painterController})
      : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  MyPageController myPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyScrollController>(
      builder: (_myScrollController) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: _myScrollController.isScroll
                ? null
                : const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                PenEraseButtons(
                  painterController: widget.painterController,
                ),
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
      },
    );
  }
}
