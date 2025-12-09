import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tush/core/presentation/widgets/widgets.dart';
import 'package:tush/core/utils/date_formatter.dart';
import 'package:tush/features/dreams/domain/entities/dream.dart';
import 'package:tush/features/dreams/presentation/bloc/dreams_bloc.dart';
import 'package:tush/routes/app_router.gr.dart';

class DreamListItem extends StatefulWidget {
  final Dream dream;
  final bool wasProcessing;

  const DreamListItem({
    super.key,
    required this.dream,
    this.wasProcessing = false,
  });

  @override
  State<DreamListItem> createState() => _DreamListItemState();
}

class _DreamListItemState extends State<DreamListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _showReadyAnimation = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.03,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.03,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_animationController);

    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_animationController);

    if (widget.wasProcessing && widget.dream.isReady) {
      _showReadyAnimation = true;
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(DreamListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.dream.isReady && widget.dream.isReady) {
      setState(() {
        _showReadyAnimation = true;
      });
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('delete_dream'.tr()),
          content: Text('delete_dream_confirmation'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<DreamsBloc>().add(
                  DreamsEvent.delete(widget.dream.id),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('delete'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _onShare() {
    final shareText = StringBuffer();
    shareText.writeln(widget.dream.title);
    shareText.writeln();
    shareText.writeln(widget.dream.text);
    if (widget.dream.interpretation != null &&
        widget.dream.interpretation!.isNotEmpty) {
      shareText.writeln();
      shareText.writeln('interpretation'.tr());
      shareText.writeln(widget.dream.interpretation);
    }
    SharePlus.instance.share(ShareParams(text: shareText.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Slidable(
      key: ValueKey(widget.dream.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _onShare(),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            icon: Icons.share,
            label: 'share'.tr(),
          ),
          SlidableAction(
            onPressed: _onDelete,
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            icon: Icons.delete,
            label: 'delete'.tr(),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _showReadyAnimation ? _scaleAnimation.value : 1.0,
            child: Container(
              decoration: _showReadyAnimation
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(
                            alpha: 0.4 * _glowAnimation.value,
                          ),
                          blurRadius: 16 * _glowAnimation.value,
                          spreadRadius: 2 * _glowAnimation.value,
                        ),
                      ],
                    )
                  : null,
              child: child,
            ),
          );
        },
        child: Card(
          child: ListTile(
            onTap: () async {
              final result = await context.router.push(
                DreamDetailRoute(dream: widget.dream),
              );
              if (result == true && context.mounted) {
                context.read<DreamsBloc>().add(const DreamsEvent.refresh());
              }
            },
            title: AppTitleSmall(text: widget.dream.title),
            subtitle: widget.dream.isReady
                ? Row(
                    children: [
                      if (_showReadyAnimation) ...[
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: AppBodySmall(
                          text: widget.dream.createdAt != null
                              ? AppDateFormatter.format(
                                  widget.dream.createdAt!,
                                  context,
                                )
                              : '',
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 8),
                      AppBodySmall(text: 'processing'.tr()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
