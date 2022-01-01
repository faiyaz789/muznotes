import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FiveLineWidget extends StatefulWidget {
  const FiveLineWidget({Key? key}) : super(key: key);

  @override
  State<FiveLineWidget> createState() => _FiveLineWidgetState();
}

class _FiveLineWidgetState extends State<FiveLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top: 17 ,bottom: 17),
      child: Stack(
        children: [
          Column(
            children: const [
              Divider(
                color: Colors.black,
                height: 6,
                thickness: 0.7,
              ),
              Divider(
                height: 6,
                color: Colors.black,
                thickness: 0.7,
              ),
              Divider(
                color: Colors.black,
                thickness: 0.7,
                height: 6,
              ),
              Divider(
                color: Colors.black,
                thickness: 0.7,
                height: 6,
              ),
              Divider(
                color: Colors.black,
                thickness: 0.7,
                height: 6,
              ),
            ],
          ),
          Positioned(
            top: 3,
            left: 10,
            child: GestureDetector(
              onLongPress: (){
                print('touch');
              },
              child: SvgPicture.asset(
                'assets/svg/soprano.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
