import 'package:flutter/material.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class CostRowWidget extends StatelessWidget {
  final String departure;
  final String destination;
  final String distance;
  final dynamic totalCost;
  final int index;

  const CostRowWidget({
    required this.departure,
    required this.destination,
    required this.distance,
    required this.totalCost,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: index.isEven ? AppColors.colorE9F5FE : Colors.white,
        border: Border.all(color: AppColors.secondaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            departure,
            style: AppStyles.fontSize16(
              color: AppColors.color707070,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            destination,
            style: AppStyles.fontSize16(
              color: AppColors.color707070,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            distance,
            style: AppStyles.fontSize16(
              color: AppColors.color707070,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            '$totalCost \$',
            style: AppStyles.fontSize16(
              color: AppColors.color707070,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
