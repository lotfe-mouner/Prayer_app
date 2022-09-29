import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout(this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            /********************** Backgroud    Imageeeee ***************/
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Image.asset(
                'assets/3.jpg',
                fit: BoxFit.fill,
              ),
            ),
            /************************* background ends here ******************/
            SafeArea(
              bottom: false,
              child: SizedBox(
                //create a Row
                child: Column(
                    children: [
                  /***************** top icons placed here ****************/
                  const SizedBox(height: 200),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: ListView(
                      children: [
                      //  Expanded(
                      //   child:
                         Container(
                            margin: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: body,
                          ),
                      //  ),
                      ],
                    ),
                  )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
