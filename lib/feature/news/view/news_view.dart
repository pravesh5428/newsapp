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
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    backgroundColor: primaryColor1,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text("MyNews"),
                        Column(
                          children:  [
                            const Text("Location",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  chooseYourLocation(context);
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 15.0,
                                    ),
                                    Text("India",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )
                                    ),
                                  ],
                                ),
                            )
                          ],
                        ),
                      ],
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                                      controller.articlesResponse[index].author ?? "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller.articlesResponse[index].title ?? "",
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
                                  image: DecorationImage(
                                    image: controller.articlesResponse[index].urlToImage==null
                                        ? const NetworkImage("http://placehold.jp/150x150.png")
                                        : NetworkImage(controller.articlesResponse[index].urlToImage),
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

  filterOfSources(context){
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
                    child: Text("Filter by sources",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
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
                child: Obx(()=> ListView.builder(
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
                                title:  Text(
                                  controller.sourceResponse[index].name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                value: controller.sourceResponse[index].isChecked,
                                onChanged: (bool val) {
                                  if(val==true) {
                                    controller.sourceResponse[index].isChecked=true;
                                  }
                                  else {
                                    controller.sourceResponse[index].isChecked=false;
                                  }
                                  controller.sourceResponse.refresh();
                                }
                            ),
                          ],
                        ),
                      );
                    }
                ),
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
        }
    );
  }

  chooseYourLocation(context){
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
                    child: Text("Filter by sources",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
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
                      return Obx(() => Container(
                          //height: 600,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile(
                                  title:  Text(
                                    controller.countryList[index].title,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: controller.countryList[index].id,
                                  groupValue: controller.index.value,
                                  onChanged: (value) {
                                     controller.title.value = controller.countryList[index].title;
                                     controller.index.value = controller.countryList[index].id;
                                     print(controller.title.value);
                                     print(controller.index.value);
                                  }
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
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
        }
    );
  }
}
