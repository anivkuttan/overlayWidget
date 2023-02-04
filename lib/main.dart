import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: const Center(
        child: OverlayButton(),
      ),
    );
  }
}

class OverlayButton extends StatefulWidget {
  const OverlayButton({Key? key}) : super(key: key);

  @override
  State<OverlayButton> createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<OverlayButton> {
  bool _isOverlayOpen = false;
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 200,
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Hello Button"),
            Icon(_isOverlayOpen ? Icons.expand_less : Icons.expand_more),
          ],
        ),
        onPressed: () {
          setState(() {
            _isOverlayOpen ? hideOverlay() : showOverlay();
            _isOverlayOpen = !_isOverlayOpen;
          });
          // ignore: avoid_print
          print(_isOverlayOpen);
        },
      ),
    );
  }

  showOverlay() {
    OverlayState? overlayState = Overlay.of(context);

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
          top: 0,
          left: 0,
          width: 100,
          child: Container(height: 30, width: 300, color: Colors.red),
        );
      });
      overlayState!.insert(overlayEntry!);
    } else {
      // ignore: avoid_print
      print("overlay entry not inserted");
    }
  }

  hideOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    } else {
      // ignore: avoid_print
      print("Overlay is null");
    }
  }
}
