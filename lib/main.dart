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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: const Center(
          child: OverlayButton(),
        ),
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
  // global key to fint the Parrent widget render box values
  final GlobalKey _parrentWidgetKey = GlobalKey();
  // link the parrent and overlayWidget
  // to get the parrentwidget position
  final LayerLink _link = LayerLink();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _parrentWidgetKey,
      height: 30,
      width: 200,
      child: CompositedTransformTarget(
        link: _link,
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
      ),
    );
  }

  showOverlay() {
    OverlayState? overlayState = Overlay.of(context);

    if (kuttansoverlayEntry == null) {
      //* make Sure ther returned variable same name as the decleared variable
      //* don't create a new OverlayEntry Variable hear
      kuttansoverlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
          top: 120,
          left: 30,
          width: 100,
          child: Material(
            //* make material widget top of the CompositedTransform Follower widget
            child: CompositedTransformFollower(
              link: _link,
              child: InkWell(
                onTap: () {
                  hideOverlay();
                },
                child: Container(height: 30, width: 300, color: Colors.red),
              ),
            ),
          ),
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
