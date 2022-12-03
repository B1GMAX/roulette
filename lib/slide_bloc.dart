import 'package:flutter/material.dart';

class SlideBloc {
  final SingleTickerProviderStateMixin _tickerProvider;

  SlideBloc(this._tickerProvider) {
    tabController = TabController(length: 3, vsync: _tickerProvider);
  }

  final PageController pageController = PageController();

  late TabController tabController;

  void changeUnderlineTabColorByOnTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void changeUnderlineTabColorByOnPageChange(int index) {
    tabController.animateTo(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void dispose() {
    _tickerProvider.dispose();
    tabController.dispose();
    pageController.dispose();
  }
}
