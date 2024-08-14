import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class SplashLifecycleOverlay extends StatefulWidget {
  final Widget child;
  final Duration splashDuration;

  final WidgetBuilder splashBuilder;

  const SplashLifecycleOverlay({
    required this.child,
    required this.splashBuilder,
    this.splashDuration = const Duration(milliseconds: 200),
    super.key,
  });

  @override
  State<SplashLifecycleOverlay> createState() => _SplashLifecycleOverlayState();
}

class _SplashLifecycleOverlayState extends State<SplashLifecycleOverlay>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animation =
      AnimationController(vsync: this, duration: _animationDuration);

  Timer? _removingTimer;

  bool get _splashVisible => _animation.value > 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animation.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Platform.isAndroid) return;

    final isInactiveApp = state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused;

    if (state == AppLifecycleState.resumed) {
      _removeSplash(widget.splashDuration);
    }

    if (isInactiveApp) {
      if (_splashVisible) _forceRemoveSplash();
      _showSplash(widget.splashBuilder);
    }
  }

  void _showSplash(WidgetBuilder builder) {
    _animation.forward();
  }

  void _removeSplash(Duration duration) {
    _cancelRemoving();

    _removingTimer = Timer(
      duration,
      () async {
        _animation.reverse();
        await Future.delayed(_animation.duration!);
      },
    );
  }

  void _forceRemoveSplash() {
    _cancelRemoving();
    _animation.reset();
  }

  void _cancelRemoving() {
    _removingTimer?.cancel();
    _removingTimer = null;
  }

  Widget _buildSplash(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        if (_animation.value == 0) return Container();

        return Opacity(
          opacity: _animation.value,
          child: widget.splashBuilder(context),
        );
      },
    );
  }

  Widget _buildChild(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        _buildSplash(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: _buildChild(context),
    );
  }
}
