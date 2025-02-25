import 'package:budget/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/spending_model.dart';

class AllSpendingComponents extends StatelessWidget {
  const AllSpendingComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.databaseHelper.fetchSpending(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<SpendingModel> spendingData = snapshot.data ?? [];

          return ListView.builder(
            itemCount: spendingData.length,
            itemBuilder: (context, index) {
              var data = SpendingModel(
                id: spendingData[index].id,
                description: spendingData[index].description,
                amount: spendingData[index].amount,
                paymentMode: spendingData[index].paymentMode,
                date: spendingData[index].date,
                categoryId: spendingData[index].categoryId,
              );
              return Container(
                height: 235.h,
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spendingData[index].description,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "₹ ${spendingData[index].amount}",
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          "DATE: ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.date,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    FutureBuilder(
                      future: DatabaseHelper.databaseHelper
                          .fetchSingleCategory(id: data.categoryId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data != null
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(),
                                  ),
                                )
                              : Container();
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        FutureBuilder(
                          future: DatabaseHelper.databaseHelper
                              .fetchSingleCategory(id: data.categoryId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data != null
                                  ? Image.memory(
                                      snapshot.data!.image,
                                      height: 50,
                                    )
                                  : Container();
                            }
                            return Container();
                          },
                        ),
                        SizedBox(width: 16.w),
                        // ActionChip(
                        //   backgroundColor: data.mode == 'online'
                        //       ? Colors.green
                        //       : Colors.yellow,
                        //   label: Text(
                        //     data.mode,
                        //     style: const TextStyle(color: Colors.white),
                        //   ),
                        // ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
