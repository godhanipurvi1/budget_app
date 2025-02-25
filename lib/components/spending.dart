import 'package:budget/helper/database_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/spending_controller.dart';
import '../model/category_model.dart';
import '../model/spending_model.dart';

TextEditingController descController = TextEditingController();
TextEditingController amountController = TextEditingController();

GlobalKey<FormState> spendingKey = GlobalKey<FormState>();

class SpendingComponents extends StatelessWidget {
  const SpendingComponents({super.key});

  @override
  Widget build(BuildContext context) {
    SpendingController controller = Get.put(SpendingController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<SpendingController>(builder: (ctx) {
        return Form(
          key: spendingKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 2,
                controller: descController,
                validator: (val) => val!.isEmpty ? "required desc...." : null,
                decoration: InputDecoration(
                  labelText: "Desc",
                  hintText: "Enter spending description...",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? "required amount...." : null,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "Enter spending amount...",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "MODE : ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  DropdownButton(
                    value: controller.mode,
                    hint: const Text("Select"),
                    items: const [
                      DropdownMenuItem(
                        value: "online",
                        child: Text("Online"),
                      ),
                      DropdownMenuItem(
                        value: "offline",
                        child: Text("Offline"),
                      ),
                    ],
                    onChanged: controller.getSpendingMode,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "DATE : ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2026),
                      );

                      if (date != null) {
                        controller.getSpendingDate(date: date);
                      }
                    },
                    icon: const Icon(Icons.date_range),
                  ),
                  if (controller.dateTime != null)
                    Text(
                      "${controller.dateTime?.day}/${controller.dateTime?.month}/${controller.dateTime?.year}",
                    )
                  else
                    const Text("DD/MM/YYYY"),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                    future: DatabaseHelper.databaseHelper.fetchCategory(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List<CategoryModel> category = snapShot.data ?? [];

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: category.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controller.getSpendingIndex(
                                index: index,
                                id: category[index].id,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: (index == controller.spendingIndex)
                                      ? Colors.grey
                                      : Colors.transparent,
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(category[index].image),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  if (spendingKey.currentState!.validate() &&
                      controller.mode != null &&
                      controller.dateTime != null &&
                      controller.spendingIndex != null) {
                    controller.addSpendingData(
                      model: SpendingModel(
                        id: 0,
                        description: descController.text,
                        amount: double.parse(amountController.text),
                        paymentMode: controller.mode!,
                        date:
                            "${controller.dateTime?.day}/${controller.dateTime?.month}/${controller.dateTime?.year}",
                        categoryId: controller.categoryId,
                      ),
                    );
                    descController.clear();
                    amountController.clear();
                    controller.assignDefaultValue();
                  } else {
                    Get.snackbar(
                      "Required",
                      "all field are required....",
                      backgroundColor: Colors.red.shade300,
                    );
                  }
                },
                label: const Text("Add Spending"),
              )
            ],
          ),
        );
      }),
    );
  }
}
