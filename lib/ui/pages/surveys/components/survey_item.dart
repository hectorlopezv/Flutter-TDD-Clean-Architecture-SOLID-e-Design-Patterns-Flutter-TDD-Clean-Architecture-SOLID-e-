import 'package:flutter/material.dart';

class SurveyItem extends StatelessWidget {
  const SurveyItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, 
          boxShadow: [
            BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0, 1)
          ), 
        ],
        borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
          Text("20 ago 2020", style: TextStyle(color: Colors.white, fontSize: 20),),
          SizedBox(height: 20,),
          Text("Qual e seu framework favorito?", style: TextStyle(color: Colors.white, fontSize: 20),)
        ],
        ),
      ),
    );
  }
}