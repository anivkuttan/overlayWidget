// ignore_for_file: avoid_print

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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar'),
            bottom: const TabBar(
              tabs: [
                Text(
                  "Tab 1",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Tab 2",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Tab 3",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.green.shade400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const SecondPage();
                            }),
                          );
                        },
                        child: const Text("NewPage"),
                      ),
                      const OverlayButton(),
                      ElevatedButton(
                        child: const Text("Hello"),
                        onPressed: () {
                          print("Hello button Pressed");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("ButtonPressed"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.yellow.shade300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const SecondPage();
                            }),
                          );
                        },
                        child: const Text("NewPage"),
                      ),
                      const OverlayButton(),
                      ElevatedButton(
                        child: const Text("Hello"),
                        onPressed: () {
                          print("Hello button Pressed");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("ButtonPressed"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.pink.shade400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const SecondPage();
                            }),
                          );
                        },
                        child: const Text("NewPage"),
                      ),
                      const OverlayButton(),
                      ElevatedButton(
                        child: const Text("Hello"),
                        onPressed: () {
                          print("Hello button Pressed");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("ButtonPressed"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
  double parrentWidth = 0.0;
  double parrentHeight = 0.0;
  // final Offset _parrentOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _parrentWidgetKey,
      width: 200,
      height: 30,
      child: CompositedTransformTarget(
        link: _link,
        child: OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_isOverlayOpen ? "Hide overlay" : "Show Overlay"),
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

  findParrentWidgetData(BuildContext context) {
    RenderBox renderBox =
        _parrentWidgetKey.currentContext!.findRenderObject() as RenderBox;
    parrentWidth = renderBox.size.width;
    parrentHeight = renderBox.size.height;
    // _parrentOffset =
    //     renderBox.localToGlobal(Offset(parrentWidth, parrentHeight));
    // print("$parrentWidth,$parrentHeight");
  }

  showOverlay() {
    OverlayState? overlayState = Overlay.of(context);
    findParrentWidgetData(context);
    if (kuttansoverlayEntry == null) {
      //* make Sure ther returned variable same name as the decleared variable
      //* don't create a new OverlayEntry Variable hear
      kuttansoverlayEntry = OverlayEntry(builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("Anikuttan Guester Called8888");
            hideOverlay();
            setState(() {
              _isOverlayOpen = false;
            });
          },
          child: Stack(
            children: [
              Positioned(
                width: parrentWidth,
                child: CompositedTransformFollower(
                  link: _link,
                  offset: Offset(0, parrentHeight + 10),
                  child: Material(
                    child: ListTile(
                      tileColor: Colors.blue,
                      title: const Text("Hello"),
                      onTap: () {
                        print("ListTile Taped");
                        hideOverlay();
                      },
                    ),
                  ),
                ),
              ),
            ],
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
    setState(() {
      if (kuttansoverlayEntry != null) {
        kuttansoverlayEntry!.remove();
        kuttansoverlayEntry = null;
        _isOverlayOpen = false;
      } else {
        // print("Overlay is null");
      }
    });
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: const Center(
        child: Text("SecondPage"),
      ),
    );
  }
}
