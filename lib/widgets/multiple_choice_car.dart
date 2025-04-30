import 'package:cos_challenge/model/multiple_choices.dart';
import 'package:cos_challenge/utils/color.dart';
import 'package:flutter/material.dart';

class MultipleChoiceCarWidget extends StatelessWidget {
  final MultipleChoices data;
  final String similarityText;
  final VoidCallback onTap;

  const MultipleChoiceCarWidget({
    super.key,
    required this.data,
    required this.similarityText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(2, 2, 2, 14),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildBanner(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;

    return Container(
      height: 32,
      color: data.getColor(),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(data.getIcon(), color: BrandColors.white, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              similarityText,
              style: style?.copyWith(color: BrandColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.make,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.model,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.containerName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 2),
          Text(data.externalId, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
