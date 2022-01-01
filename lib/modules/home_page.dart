import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muznotes/controllers/page_controller.dart';
import 'package:muznotes/controllers/scroll_controller.dart';
import 'package:muznotes/modules/image_screen.dart';
import 'package:muznotes/utils/painter.dart';
import 'package:muznotes/values/app_strings.dart';
import 'package:muznotes/values/colors.dart';
import 'package:screenshot/screenshot.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController(initialPage: 0);
  //static const _kDuration = const Duration(milliseconds: 300);
  //static const _kCurve = Curves.ease;
  MyPageController myPageController = Get.find();
  MyScrollController myScrollController = Get.find();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.grey,
      ),
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColor.colorDarkGrey,
        title: const Text(AppString.txtAppName),
        actions: [
          GetBuilder<MyScrollController>(builder: (context) {
            return Checkbox(
              value: myScrollController.isScroll,
              onChanged: (val) {
                myScrollController.onToggle();
              },
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => _show(context),
              icon: const Icon(Icons.share),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              AppString.txtNoteHeading,
              style: TextStyle(fontSize: 26, color: AppColor.colorHeading),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  currentPage = index;
                  setState(() {});
                },
                controller: pageController,
                children: [
                  ...myPageController.pages,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (myPageController.pages.length > 3) {
                        setState(() {
                          //print(currentPage);
                          myPageController.deletePage(currentPage);
                          if (currentPage != 0) {
                            currentPage--;
                            pageController.jumpToPage(currentPage);
                          }
                        });
                      }
                    },
                    child: const Text(
                      'DELETE PAGE',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: myPageController.pages.length > 3
                          ? AppColor.colorLightPink
                          : Colors.black12,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        myPageController.addPage();
                      });
                    },
                    child: const Text('NEW SITE'),
                    style: ElevatedButton.styleFrom(
                        elevation: 0, primary: AppColor.colorHeading),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Text(
                    'page:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageController.jumpToPage(0);
                      });
                    },
                    child: const Text(
                      '<<-',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' 0${currentPage + 1} ',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.colorHeading),
                  ),
                  Visibility(
                    visible: myPageController.pages.length - currentPage > 1
                        ? true
                        : false,
                    child: Text(
                      '| 0${currentPage + 2} ',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: myPageController.pages.length - currentPage > 2
                        ? true
                        : false,
                    child: Text(
                      '| 0${currentPage + 3} ',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageController
                            .jumpToPage(myPageController.pages.length - 1);
                      });
                    },
                    child: const Text(
                      '->>',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _show(BuildContext context) async {
    final controller = ScreenshotController();
    GlobalKey key = GlobalKey();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImagePage()),
    );
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: const Text('View your image'),
    //         ),
    //         body: Container(
    //           alignment: Alignment.center,
    //           child: FutureBuilder<Uint8List?>(
    //             future: myPageController.capture(),
    //             builder:
    //                 (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
    //               switch (snapshot.connectionState) {
    //                 case ConnectionState.done:
    //                   if (snapshot.hasError) {
    //                     return Text('Error: ${snapshot.error}');
    //                   } else {
    //                     return PrintWidget(
    //                         painterController:
    //                             myPageController.painterController1!);
    //                   }
    //                 default:
    //                   return const FractionallySizedBox(
    //                     widthFactor: 0.1,
    //                     child: AspectRatio(
    //                       aspectRatio: 1.0,
    //                       child: CircularProgressIndicator(),
    //                     ),
    //                     alignment: Alignment.center,
    //                   );
    //               }
    //             },
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  const DrawBar(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
          );
        })),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return RotatedBox(
                quarterTurns: _controller.eraseMode ? 2 : 0,
                child: IconButton(
                    icon: const Icon(Icons.create),
                    tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                        ' eraser',
                    onPressed: () {
                      setState(() {
                        _controller.eraseMode = !_controller.eraseMode;
                      });
                    }));
          },
        ),
      ],
    );
  }
}
