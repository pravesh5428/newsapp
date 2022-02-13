import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/core/constant/colors_constant.dart';
import 'package:newsapp/feature/news/controller/news_controller.dart';

class NewsView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: secondryColor1,
      body: Obx(()=>  controller.isLoading.value==true
          ? const SizedBox(
          child: Center(child: CircularProgressIndicator())):CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: primaryColor1,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "MyNEWS",
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "LOCATION",
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        "India",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: secondryColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Search for news, topics...',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Top Headlines",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600, // light
                          ),
                        ),
                        Row(
                          children: [
                            const Text("Sort: "),
                            Obx(
                              () => DropdownButton(
                                value: controller.dropdownvalue.value,
                                icon: const Icon(Icons.arrow_drop_down),
                                items: controller.items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.dropdownvalue.value =
                                      newValue.toString();
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    child: Text(controller.articlesResponse[index].author??"pravesh"),
                  );
                },
                childCount: controller.articlesResponse.length,
              )),
          ],
        ),
      ),
    );
  }
}
