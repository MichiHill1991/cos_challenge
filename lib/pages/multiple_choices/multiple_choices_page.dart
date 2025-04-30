import 'package:cos_challenge/model/multiple_choices.dart';
import 'package:cos_challenge/widgets/multiple_choice_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultipleChoicesPage extends StatelessWidget {
  final List<MultipleChoices> data;

  const MultipleChoicesPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.appBarMultipleChoice)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            loc.multipleSelectorTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            loc.multipleSelectorSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ...data.map((d) {
            return MultipleChoiceCarWidget(
              data: d,
              similarityText: getSimilarityText(loc, d.similarity),
              onTap: () => _onTap(d),
            );
          }),
        ],
      ),
    );
  }

  void _onTap(MultipleChoices selected) {}

  String getSimilarityText(AppLocalizations loc, int similarity) {
    if (similarity > 75) return loc.multipleSimilarityHigh;
    if (similarity >= 50) return loc.multipleSimilarityMedium;
    return loc.multipleSimilarityLow;
  }
}
