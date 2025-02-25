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
      builder: (context, spendingSnapshot) {
        if (spendingSnapshot.hasData) {
          List<SpendingModel> spendingList = spendingSnapshot.data ?? [];

          return ListView.builder(
            itemCount: spendingList.length,
            itemBuilder: (context, index) {
              var spendingItem = SpendingModel(
                id: spendingList[index].id,
                description: spendingList[index].description,
                amount: spendingList[index].amount,
                paymentMode: spendingList[index].paymentMode,
                date: spendingList[index].date,
                categoryId: spendingList[index].categoryId,
              );
              return Container(
                height: 200.h,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spendingList[index].description,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "₹ ${spendingList[index].amount}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "DATE : ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          spendingItem.date,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FutureBuilder(
                      future: DatabaseHelper.databaseHelper
                          .fetchSingleCategory(id: spendingItem.categoryId),
                      builder: (context, categorySnapshot) {
                        if (categorySnapshot.hasData) {
                          return (categorySnapshot.data != null)
                              ? Text(
                                  categorySnapshot.data!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : Container();
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        FutureBuilder(
                          future: DatabaseHelper.databaseHelper
                              .fetchSingleCategory(id: spendingItem.categoryId),
                          builder: (context, categorySnapshot) {
                            if (categorySnapshot.hasData) {
                              return (categorySnapshot.data != null)
                                  ? Image.memory(
                                      categorySnapshot.data!.image,
                                      height: 50,
                                    )
                                  : Container();
                            }
                            return Container();
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ActionChip(
                          backgroundColor:
                              (spendingItem.paymentMode == 'online')
                                  ? Colors.green
                                  : Colors.yellow,
                          label: Text(spendingItem.paymentMode),
                        ),
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
                    )
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
