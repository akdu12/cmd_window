import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: CMDWindowManager(
        child: Scaffold(),
      ),
    );
  }
}

class CMDWindowManager extends StatefulWidget {
  final Widget child;

  CMDWindowManager({required this.child});

  @override
  State createState() => _CMDWindowManagerState();

  static _CMDWindowManagerState? of(BuildContext context) {
    final cmdWindowMangerState =
        context.findAncestorStateOfType<_CMDWindowManagerState>();
    assert(() {
      if (cmdWindowMangerState == null) {
        throw FlutterError(
            'CMDWindowManager operation requested with a context that does not include a CMDWindowManager.\n'
            'The context used to show CMDWindowManager must be that of a widget '
            'that is a descendant of a CMDWindowManager widget.');
      }
      return true;
    }());
    return cmdWindowMangerState;
  }
}

class _CMDWindowManagerState extends State<CMDWindowManager> {
  Map<Widget, Offset> windows = {
    CMDWindow(): Offset.zero,
    CMDWindow(): Offset.zero
  };
  String prefix = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          widget.child,
          ...windows.keys
              .map((e) => Positioned(
                    left: windows[e]!.dx,
                    top: windows[e]!.dy,
                    child: Draggable(
                      onDragEnd: (details) {
                        setState(() {
                          windows.remove(e);
                          windows[e] = details.offset;
                        });
                      },
                      child: e,
                      feedback: Material(child: e),
                      childWhenDragging: SizedBox.shrink(),
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}

class CMDWindow extends StatefulWidget {
  @override
  State createState() => _CMDWindowState();
}

class _CMDWindowState extends State<CMDWindow> {
  final controller = TextEditingController(text: "Cmd-Window-Pro:~ User \$");

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.selection.extentOffset <
          "Cmd-Window-Pro:~ User \$".length) {
        controller
          ..selection = controller.selection
              .copyWith(extentOffset: "Cmd-Window-Pro:~ User \$".length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      height: 450,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(0, 15),
                spreadRadius: 10)
          ]),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 25),
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
                        width: 12,
                        height: 12),
                    const SizedBox(width: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                        width: 12,
                        height: 12),
                    const SizedBox(width: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent, shape: BoxShape.circle),
                        width: 12,
                        height: 12),
                    const SizedBox(width: 10),
                  ],
                ),
                Expanded(
                    child: Text("roblef ―― bash ―― 80x24",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceCodePro(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: -0.5,
                            height: 1))),
                Icon(Icons.exit_to_app)
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last login : Tue Jan 28 10:00:35 on console\n",
                    style: GoogleFonts.sourceCodePro(
                        color: const Color(0xff3aa832),
                        fontSize: 12,
                        letterSpacing: -0.5,
                        height: 1)),
                Flexible(
                  child: Container(
                    child: TextField(
                      controller: controller,
                      inputFormatters: [
                        ForcePrefixInputFormatter(
                            prefix: "Cmd-Window-Pro:~ User \$ ")
                      ],
                      autofocus: true,
                      maxLines: null,
                      style: GoogleFonts.sourceCodePro(
                          color: const Color(0xff3aa832),
                          letterSpacing: -0.5,
                          fontSize: 12,
                          height: 1),
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
