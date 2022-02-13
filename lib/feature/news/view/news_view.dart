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
      body: Obx(
        () => controller.isLoading.value == true
            ? const SizedBox(child: Center(child: CircularProgressIndicator()))
            : CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    backgroundColor: primaryColor1,
                    title: Text(
                      "MyNEWS",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
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
                                      items:
                                          controller.items.map((String items) {
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
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x198ba5b0),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                              .articlesResponse[index].author ??
                                          "pravesh",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller
                                              .articlesResponse[index].title ??
                                          "pravesh",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width * 0.3,
                                height: height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "http://placehold.jp/150x150.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
