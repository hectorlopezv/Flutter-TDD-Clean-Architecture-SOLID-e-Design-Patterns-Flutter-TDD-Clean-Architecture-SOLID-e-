import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/components/survey_item.dart';

class SurveysPage extends StatelessWidget {
  const SurveysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enquentes"),),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CarouselSlider(
          items: [
            SurveyItem(),SurveyItem(),SurveyItem() 
            ], 
          options: CarouselOptions(aspectRatio: 1, enlargeCenterPage: true),),
      )
    );
  }
}
