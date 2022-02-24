import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/core/constant/colors_constant.dart';
import 'package:newsapp/feature/news/controller/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key key}) : super(key: key);

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
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    backgroundColor: secondryColor1,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Catalog App',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Trending Products',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(height * 0.17),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(12),
                              ),
                              onChanged: (text) {
                                //print('First text field: $text');
                                controller.q.value = text;
                                Future.delayed(const Duration(seconds: 2), () {
                                  controller.getNewsListData();
                                });
                              }),
                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.25,
                                  height: height * 0.17,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: controller.articlesResponse[index]
                                                  .urlToImage ==
                                              null
                                          ? const NetworkImage(
                                              "http://placehold.jp/150x150.png")
                                          : NetworkImage(controller
                                              .articlesResponse[index]
                                              .urlToImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: width * 0.55,
                                  height: height * 0.17,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.articlesResponse[index]
                                                    .author ??
                                                "",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            controller.articlesResponse[index]
                                                    .title ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "800",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              primary: Colors.blueGrey,
                                              onPrimary:
                                                  Colors.white, // foreground
                                            ),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.shopping_cart_outlined,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: controller.articlesResponse.length,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          filterOfSources(context);
        },
        backgroundColor: primaryColor1,
        child: const Icon(Icons.filter_list_alt),
      ),
    );
  }

  filterOfSources(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Filter by sources",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 1.0,
                color: secondryColor2,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 315,
                width: double.infinity,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.sourceResponse.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          //height: 600,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                  activeColor: Colors.pink[300],
                                  dense: true,
                                  //font change
                                  title: Text(
                                    controller.sourceResponse[index].name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: controller
                                      .sourceResponse[index].isChecked,
                                  onChanged: (bool val) {
                                    if (val == true) {
                                      controller.sourceResponse[index]
                                          .isChecked = true;
                                    } else {
                                      controller.sourceResponse[index]
                                          .isChecked = false;
                                    }
                                    controller.sourceResponse.refresh();
                                  }),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              ElevatedButton(
                child: const Text("Apply Filter"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor1,
                ),
              )
            ],
          );
        });
  }

  chooseYourLocation(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Filter by sources",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 1.0,
                color: secondryColor2,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 315,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.countryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Container(
                          //height: 600,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile(
                                  title: Text(
                                    controller.countryList[index].title,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: controller.countryList[index].id,
                                  groupValue: controller.index.value,
                                  onChanged: (value) {
                                    controller.title.value =
                                        controller.countryList[index].title;
                                    controller.index.value =
                                        controller.countryList[index].id;
                                    print(controller.title.value);
                                    print(controller.index.value);
                                  }),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              ElevatedButton(
                child: const Text("Apply"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor1,
                ),
              )
            ],
          );
        });
  }
}
