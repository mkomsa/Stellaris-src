import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellaris_app/providers/sol_index_provider.dart';

class SolList extends ConsumerStatefulWidget {
  const SolList({required this.solKeys, Key? key}) : super(key: key);

  final List<String> solKeys;

  @override
  ConsumerState<SolList> createState() {
    return _SolListState();
  }
}

class _SolListState extends ConsumerState<SolList> {
  late List<String> sols;

  @override
  void initState() {
    super.initState();
    sols = widget.solKeys;
  }

  @override
  Widget build(BuildContext context) {
    int selectedSolIndex = ref.watch(selectedSolIndexProvider);

    final currentTheme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: deviceHeight * 0.08,
      width: deviceWidth,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 128,
        diameterRatio: 4,
        perspective: 0.01,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            ref.read(selectedSolIndexProvider.notifier).setIndex(index);
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (BuildContext context, int index) {
            final sol = sols[selectedSolIndex];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'SOL $sol',
                    style: currentTheme.textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.65),
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: sols.length,
        ),
      ),
    );
  }
}
