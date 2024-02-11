import 'package:flutter/material.dart';
import 'package:smartrefresh/smartrefresh.dart';

class WRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback onRefresh;
  const WRefresher({
    Key? key,
    required this.controller,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PullToRefresh(
        showChildOpacityTransition: false,
        tColor: Colors.transparent,
        onFail: const SizedBox(),
        onComplete: const SizedBox(),
        onLoading: const Text("Loading..."),
        onRefresh: onRefresh,
        refreshController: controller,
        child: child);
  }
}