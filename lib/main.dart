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
 /* 
  * decleare the variables 
  * overlayEntry , and  isOverlayOpen  
  * in build method return the parrentWidget(base Button)
  * create showOverlay and HideOverlay method
  * in Showoverlay method create OverlayState variable 
  * and Check is Early created overlayEntry variable null 
  * then in the If condition block build the OverlayWidgetDesign 
  * (otherwise the Show method only check the Overlay entry variable is null or not it is null then Exit the ShowOverlay Method)
  * after the build OverlayWidgetDesign add the overlayWidget into overlaystate variable using insert buildin method
  * (make Sure the early created OverlayEntry variable name same as Overlay Widget and Insert method)
  * (otherwise the overlay allway is be null )

  * OverlayEntry? anioverlay;
  * if(anioverlay == null){
  * anioverlay = OverlayEntry(builder:(){});
  * }
  * Overlay.of(context)!.insert(anioverlay);

 */
  bool _isOverlayOpen = false;
  OverlayEntry? kuttansoverlayEntry;

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
            //* is overlay open it Call Hide Method
            _isOverlayOpen ? hideOverlay() : showOverlay();
            //* toggle the Variable to show And Hide
            _isOverlayOpen = !_isOverlayOpen;
          });
          // print(_isOverlayOpen);
        },
      ),
    );
  }

  showOverlay() {
    OverlayState? overlayState = Overlay.of(context);

    if (kuttansoverlayEntry == null) {
      //* make Sure ther returned variable same name as the decleared variable 
      //* don't create a new OverlayEntry Variable heae
      kuttansoverlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
          top: 0,
          left: 0,
          width: 100,
          child: Container(height: 30, width: 300, color: Colors.red),
        );
      });
      //* make Sure the inserted OverlayEntry name is same as First Created variable
      overlayState!.insert(kuttansoverlayEntry!);
    } else { 
      // print("overlay entry not inserted");
    }
  }

  hideOverlay() {
    //* checking to avodi null error
    if (kuttansoverlayEntry != null) {
      kuttansoverlayEntry!.remove();
      kuttansoverlayEntry = null;
    } else {
      // print("Overlay is null");
    }
  }
}
