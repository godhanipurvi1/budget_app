import 'package:budget/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/spending_controller.dart';
import '../model/category_model.dart';
import '../model/spending_model.dart';

TextEditingController descriptionController = TextEditingController();
TextEditingController amountController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class SpendingForm extends StatelessWidget {
  const SpendingForm({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SpendingController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<SpendingController>(builder: (ctx) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 2,
                controller: descriptionController,
                validator: (val) =>
                    val!.isEmpty ? "Description is required." : null,
                decoration: InputDecoration(
                  labelText: "Description",
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
                validator: (val) => val!.isEmpty ? "Amount is required." : null,
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
                    "Payment Mode: ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  DropdownButton(
                    value: controller.paymentMode,
                    hint: const Text("Select Mode"),
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
                    onChanged: controller.updatePaymentMode,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Select Date: ",
                    style: TextStyle(
                      fontSize: 17.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2026),
                      );

                      if (selectedDate != null) {
                        controller.updateSpendingDate(date: selectedDate);
                      }
                    },
                    icon: const Icon(Icons.date_range),
                  ),
                  if (controller.selectedDate != null)
                    Text(
                      "${controller.selectedDate?.day}/${controller.selectedDate?.month}/${controller.selectedDate?.year}",
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
                        List<CategoryModel> categories = snapShot.data ?? [];

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controller.selectCategory(
                                index: index,
                                categoryId: categories[index].id,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: (index ==
                                          controller.selectedCategoryIndex)
                                      ? Colors.grey
                                      : Colors.transparent,
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(categories[index].image),
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
                  if (formKey.currentState!.validate() &&
                      controller.paymentMode != null &&
                      controller.selectedDate != null &&
                      controller.selectedCategoryIndex != null) {
                    controller.addSpending(
                      spending: SpendingModel(
                        id: 0,
                        description: descriptionController.text,
                        amount: double.parse(amountController.text),
                        paymentMode: controller.paymentMode!,
                        date:
                            "${controller.selectedDate?.day}/${controller.selectedDate?.month}/${controller.selectedDate?.year}",
                        categoryId: controller.selectedCategoryId,
                      ),
                    );
                    descriptionController.clear();
                    amountController.clear();
                    controller.resetDefaultValues();
                  } else {
                    Get.snackbar(
                      "Required Fields",
                      "All fields are required.",
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
