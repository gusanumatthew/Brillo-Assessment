import 'package:brilloconnetz_test/src/features/authentication/model/interest_model.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InterestTile extends ConsumerStatefulWidget {
  final Interest model;
  const InterestTile({
    super.key,
    required this.model,
  });

  @override
  ConsumerState<InterestTile> createState() => _InterestTileState();
}

class _InterestTileState extends ConsumerState<InterestTile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final tops = ref.watch(registerProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme.onPrimary, width: 3),
          color: tops.selectedInterest.contains(widget.model.id)
              ? colorScheme.onSurface
              : colorScheme.onPrimary),
      child: Text(
        widget.model.name,
        style: textTheme.overline,
      ),
    );
  }
}

class SelectedTile extends ConsumerWidget {
  final Interest model;
  const SelectedTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final tops = ref.watch(registerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme.onPrimary, width: 3),
          color: tops.pressColor.contains(model.id)
              ? colorScheme.onPrimary
              : colorScheme.onSurface),
      child: Text(
        model.name,
        style: textTheme.overline,
      ),
    );
  }
}
