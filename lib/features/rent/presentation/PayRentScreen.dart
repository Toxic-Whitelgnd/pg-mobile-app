import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/core/constants/constants.dart';

class PayRentScreen extends StatelessWidget {
  const PayRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay Rent"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: 500,
              child: Stack(

                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 330,
                      height: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: CustomColors.primary1,
                        boxShadow: const [
                        BoxShadow(
                          blurRadius: 1.1,
                          spreadRadius: 1.3,
                          offset: Offset(2,4),
                          color: Colors.black12
                        ),
                        ]
                      ),
                      child: const Center(child: Text("",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.white
                        ),
                      )),
                    ),
                  ),
                Positioned(
                  child: Image.asset('$IMG_DIR/payrent.png',
                  ),
                ),
                Positioned(
                  top: 320,
                  child: GestureDetector(
                    onTap: (){
                      print("navigate to phonepe");
                    },
                    child: Container(
                      width: 330,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColors.secondary1,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1.1,
                            spreadRadius: 1.3,
                            offset: Offset(4,6),

                          ),
                        ]
                      ),
                      child: const Center(child: Text("Pay Rent \$7500",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white
                      ),
                      )),
                    ),
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
}
