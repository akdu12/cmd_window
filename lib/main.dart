import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commands bases website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DraggableArea(),
    );
  }
}

class DraggableArea extends StatefulWidget {
  @override
  State createState() => _DraggableArea();
}

class _DraggableArea extends State<DraggableArea> {
  Offset _currentOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: _currentOffset.dx,
            top: _currentOffset.dy,
            child: Draggable(
              onDragEnd: (details) {
                setState(() {
                  _currentOffset = details.offset;
                });
              },
              child: CMDWindow(),
              feedback: Material(child: CMDWindow()),
              childWhenDragging: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class CMDWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750,
      height: 500,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 15,
                offset: Offset(0, 15),
                spreadRadius: 10)
          ]),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 28),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4, 1],
                    colors: [Colors.white, Colors.grey.withOpacity(0.1)])),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        width: 15,
                        height: 15),
                    const SizedBox(width: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                        width: 15,
                        height: 15),
                    const SizedBox(width: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent, shape: BoxShape.circle),
                        width: 15,
                        height: 15),
                    const SizedBox(width: 10),
                  ],
                ),
                Expanded(
                    child: Text(
                  "roblef -- bash  -- 80x24",
                  textAlign: TextAlign.center,
                )),
                Icon(Icons.exit_to_app)
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last login : Tue Jan 28 10:00:35 on console\n",
                    style: TextStyle(color: const Color(0xff3aa832))),
                Flexible(
                  child: Container(
                    child: TextField(
                      controller: TextEditingController(
                          text: "Cmd-Window-Pro:~ User \$"),
                      inputFormatters: [
                        ForcePrefixInputFormatter(
                            prefix: "Cmd-Window-Pro:~ User \$ ")
                      ],
                      autofocus: true,
                      maxLines: 100,
                      style: TextStyle(
                          color: const Color(0xff3aa832),
                          height: 1,
                          letterSpacing: 0.5),
                      cursorColor: const Color(0xff3aa832),
                      cursorHeight: 20,
                      cursorWidth: 7,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class ForcePrefixInputFormatter extends TextInputFormatter {
  final String prefix;

  ForcePrefixInputFormatter({this.prefix = ""});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text =
        newValue.text.startsWith(prefix) ? newValue.text : prefix;
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
