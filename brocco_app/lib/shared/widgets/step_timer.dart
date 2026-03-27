import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'buttons/pushable_3d_button.dart';
/// A countdown timer widget for a recipe step.
///
/// [duration] — the initial countdown time.
/// [onTimeEnd] — optional callback invoked when the timer reaches zero.
class StepTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onTimeEnd;

  const StepTimer({
    super.key,
    required this.duration,
    this.onTimeEnd,
  });

  @override
  State<StepTimer> createState() => _StepTimerState();
}

class _StepTimerState extends State<StepTimer> {
  late Duration _remaining;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
  }

  @override
  void didUpdateWidget(StepTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _timer?.cancel();
      _timer = null;
      setState(() {
        _remaining = widget.duration;
        _isRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_remaining == Duration.zero) return;

    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_remaining <= const Duration(seconds: 1)) {
          _timer?.cancel();
          setState(() {
            _remaining = Duration.zero;
            _isRunning = false;
          });
          widget.onTimeEnd?.call();
        } else {
          setState(() {
            _remaining -= const Duration(seconds: 1);
          });
        }
      });
    }
  }

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (h > 0) {
      return '$h:$m:$s';
    }
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final bool finished = _remaining == Duration.zero;

    return Pushable3DButton(
      onPressed: finished ? null : _toggleTimer,
      backgroundColor: Colors.white,
      shadowColor: AppColors.accentGreen,
      shadowOffset: 4.0,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.accentGreen, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _format(_remaining),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: finished ? AppColors.greyText : AppColors.primaryText,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: finished ? AppColors.greyText : AppColors.primaryOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
