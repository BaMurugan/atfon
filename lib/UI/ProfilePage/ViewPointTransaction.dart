import 'package:autofon_seller/Controller/Profile_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewPointTransaction extends StatefulWidget {
  const ViewPointTransaction({super.key});

  @override
  State<ViewPointTransaction> createState() => _ViewPointTransactionState();
}

class _ViewPointTransactionState extends State<ViewPointTransaction> {
  final profileService = Get.find<ProfileService>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  builder: (context, scrollController) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Transaction History',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: profileService
                                    .rewardPointModule.data!.isEmpty
                                ? Center(
                                    child: Text('No transactions available.'))
                                : SingleChildScrollView(
                                    controller: scrollController,
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        border:
                                            TableBorder(bottom: BorderSide()),
                                        columns: [
                                          _buildColumn('Date'),
                                          _buildColumn('Event'),
                                          _buildColumn('Referral Code'),
                                          _buildColumn('Particulars'),
                                          _buildColumn('Platform Allocated'),
                                          _buildColumn('Points Earned'),
                                          _buildColumn('Points Redeemed'),
                                          _buildColumn('Total Points'),
                                        ],
                                        rows: profileService
                                            .rewardPointModule.data!
                                            .map(
                                              (data) => DataRow(
                                                cells: [
                                                  _buildCell(
                                                      DateFormat('dd/MMM/yyyy')
                                                          .format(data
                                                              .createdAt!
                                                              .toLocal())),
                                                  _buildCell(data.event ?? ''),
                                                  _buildCell(
                                                      data.referralCode ?? ''),
                                                  _buildCell(
                                                      data.particulars ?? ''),
                                                  _buildCell(
                                                      data.platformAllocated ??
                                                          ''),
                                                  _buildCell(data.pointsEarned
                                                      .toString()),
                                                  _buildCell(data.pointsRedeemed
                                                      .toString()),
                                                  _buildCell(data.totalPoints
                                                      .toString()),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text(
            profileService.userPoint.data?.balance ?? 'N/A',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }

  /// Helper function to create a DataColumn with styling
  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Helper function to create a DataCell
  DataCell _buildCell(String value) {
    return DataCell(
      Text(
        value,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
