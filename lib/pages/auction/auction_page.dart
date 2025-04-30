import 'package:cos_challenge/model/success.dart';
import 'package:cos_challenge/utils/color.dart';
import 'package:cos_challenge/utils/price_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuctionPage extends StatelessWidget {
  final Success data;

  const AuctionPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.appBarAuction)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(data.make, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 2),
          Text(data.model, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            data.externalId.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          Text(
            data.id.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Divider(height: 1, color: BrandColors.neutral300),
          const SizedBox(height: 24),
          Text(
            loc.auctionCurrentBit,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 2),
          Text(
            PriceUtils.formatEuroPrice(context, data.price),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          !data.positiveCustomerFeedback
              ? _buildSuccess(context, loc)
              : _buildFeedback(context, loc),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BrandColors.successGreen,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: BrandColors.brand, size: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.auctionAcceptedTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  loc.auctionAcceptedSubTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedback(BuildContext context, AppLocalizations loc) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: BrandColors.errorRed,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.auctionRejectedTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                loc.auctionRejectedFeedback,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "\"${data.feedback}\"",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(loc.auctionRejectedAdjustButton),
          ),
        ),
      ],
    );
  }
}
