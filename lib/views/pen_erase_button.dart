import 'package:flutter/material.dart';
import 'package:muznotes/utils/painter.dart';
import 'package:muznotes/values/colors.dart';

enum SingingCharacter { pen, eraser }

class PenEraseButtons extends StatefulWidget {
  final PainterController painterController;
  const PenEraseButtons({Key? key, required this.painterController}) : super(key: key);

  @override
  _PenEraseButtonsState createState() => _PenEraseButtonsState();
}

class _PenEraseButtonsState extends State<PenEraseButtons> {
  SingingCharacter? _character = SingingCharacter.pen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Pen'),
              Radio<SingingCharacter>(
                activeColor: AppColor.colorHeading,
                value: SingingCharacter.pen,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(
                    () {
                      widget.painterController.eraseMode = false;
                      _character = value;
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Eraser'),
              Radio<SingingCharacter>(
                activeColor: AppColor.colorHeading,
                value: SingingCharacter.eraser,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    widget.painterController.eraseMode = true;
                    _character = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
