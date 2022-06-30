

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

import '../pages/surveys/components/survey_item.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModels;
  const SurveyItems({
    Key? key,
   required this.viewModels
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: (
        CarouselSlider(
        items: viewModels
            ?.map((viewModel) => SurveyItem(
                  viewModel: viewModel,
                ))
            .toList(),
        options:
            CarouselOptions(aspectRatio: 1, enlargeCenterPage: true),
      )
      ),
    );
  }
}