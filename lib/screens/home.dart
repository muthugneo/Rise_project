
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rise_gfa/screens/todays_deal_products.dart';
import 'package:rise_gfa/screens/top_selling_products.dart';

import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

import '../app_config.dart';
import '../custom/toast_component.dart';
import '../helpers/shimmer_helper.dart';
import '../my_theme.dart';
import '../repositories/category_repository.dart';
import '../repositories/product_repository.dart';
import '../repositories/sliders_repository.dart';
import '../ui_elements/product_card.dart';
import '../ui_sections/drawer.dart';
import 'category_list.dart';
import 'category_products.dart';
import 'filter.dart';
import 'flash_deal_list.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title, this.show_back_button = false}) : super(key: key);

  final String? title;
  bool show_back_button;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController? _featuredProductScrollController;

  AnimationController? pirated_logo_controller;
  Animation? pirated_logo_animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
    if (AppConfig.purchase_code == "") {
      initPiratedAnimation();
    }
  }

  initPiratedAnimation() {
    pirated_logo_controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    pirated_logo_animation = Tween(begin: 40.0, end: 60.0).animate(
        CurvedAnimation(
            curve: Curves.bounceOut, parent: pirated_logo_controller!));

    pirated_logo_controller?.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        pirated_logo_controller?.repeat();
      }
    });

    pirated_logo_controller?.forward();
  }

  @override
  void dispose() {
    pirated_logo_controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //print(MediaQuery.of(context).viewPadding.top);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: buildAppBar(statusBarHeight, context)),
        drawer: const MainDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                //  AppConfig.purchase_code == "" ? Padding(
                //     padding: const EdgeInsets.fromLTRB(
                //       8.0,
                //       16.0,
                //       8.0,
                //       0.0,
                //     ),
                //     child: Container(
                //       height: 140,
                //       color: Colors.black,
                //       child: Stack(
                //         children: [
                //           Positioned(
                //               left: 20,
                //               top: 0,
                //               child: AnimatedBuilder(
                //                   animation: pirated_logo_animation,
                //                   builder: (context, child) {
                //                     return Image.asset(
                //                       "assets/pirated_square.png",
                //                       height: pirated_logo_animation.value,
                //                       color: Colors.white,
                //                     );
                //                   })),
                //           Center(
                //             child: Padding(
                //               padding: const EdgeInsets.only(
                //                   top: 24.0, left: 24, right: 24),
                //               child: Text(
                //                 "This is a pirated app. Do not use this. It may have security issues.",
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 18),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ):Container(),
                // Container(
                //   height: kToolbarHeight +
                //       statusBarHeight -
                //       (MediaQuery.of(context).viewPadding.top > 40
                //           ? 16.0
                //           : 16.0),
                //   //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
                //   child: Container(
                //     child: Padding(
                //         padding: const EdgeInsets.only(
                //             top: 14.0, right: 12, left: 12),
                //         // when notification bell will be shown , the right padding will cease to exist.
                //         child: GestureDetector(
                //             onTap: () {
                //               Navigator.push(context,
                //                   MaterialPageRoute(builder: (context) {
                //                 return Filter();
                //               }));
                //             },
                //             child: buildHomeSearchBox(context))),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    8.0,
                    8.0,
                    0.0,
                  ),
                  child: buildHomeCarouselSlider(context),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    8.0,
                    8.0,
                    0.0,
                  ),
                  child: buildHomeMenuRow(context),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    8.0,
                    8.0,
                    0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Featured Categories",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  8.0,
                  0.0,
                  0.0,
                ),
                child: SizedBox(
                  height: 138,
                  child: buildHomeFeaturedCategories(context),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    8.0,
                    8.0,
                    0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Featured Products",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          4.0,
                          0.0,
                          8.0,
                          0.0,
                        ),
                        child: buildHomeFeaturedProducts(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                )
              ]),
            ),
          ],
        ));
  }

  buildHomeFeaturedProducts(context) {
    return FutureBuilder(
        future: ProductRepository().getFeaturedProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            /*print("product error");
            print(snapshot.error.toString());*/
            return Container();
          } else if (snapshot.hasData) {
            //snapshot.hasData
            dynamic featuredProductResponse = snapshot.data;

            return GridView.builder(
              // 2
              //addAutomaticKeepAlives: true,
              itemCount: featuredProductResponse.products.length,
              controller: _featuredProductScrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.610),
              padding: const EdgeInsets.all(8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // 3
                return ProductCard(
                  id: featuredProductResponse.products[index].id,
                  image:
                      featuredProductResponse.products[index].thumbnail_image,
                  name: featuredProductResponse.products[index].name,
                  price: featuredProductResponse.products[index].base_price,
                );
              },
            );
          } else {
            return ShimmerHelper().buildProductGridShimmer(
                scontroller: _featuredProductScrollController);
          }
        });
  }

  buildHomeFeaturedCategories(context) {
    return FutureBuilder(
        future: CategoryRepository().getFeturedCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //snapshot.hasError
            /*print("Home slider error");
            print(snapshot.error.toString());*/
            return Container();
          } else if (snapshot.hasData) {
            //snapshot.hasData
            dynamic featuredCategoryResponse = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredCategoryResponse.categories.length,
                itemExtent: 120,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: GestureDetector(
                      /*onTap: () {
                        if (featuredCategoryResponse
                                .categories[index].number_of_children >
                            0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoryList(
                              parent_category_name: featuredCategoryResponse
                                  .categories[index].name,
                            );
                          }));
                        } else {
                          ToastComponent.showDialog(
                              "No sub categories available", context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }
                      },*/
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryProducts(
                            category_id:
                                featuredCategoryResponse.categories[index].id,
                            category_name:
                                featuredCategoryResponse.categories[index].name,
                          );
                        }));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: MyTheme.light_grey, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                //width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                        bottom: Radius.zero),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/placeholder.png',
                                      image: AppConfig.BASE_PATH +
                                          featuredCategoryResponse
                                              .categories[index].banner,
                                      fit: BoxFit.cover,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                              child: SizedBox(
                                height: 15,
                                child: Text(
                                  featuredCategoryResponse
                                      .categories[index].name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 12, color: MyTheme.font_grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ShimmerHelper().buildBasicShimmer(
                        height: 120.0,
                        width: (MediaQuery.of(context).size.width - 32) / 3)),
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ShimmerHelper().buildBasicShimmer(
                        height: 120.0,
                        width: (MediaQuery.of(context).size.width - 32) / 3)),
                Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: ShimmerHelper().buildBasicShimmer(
                        height: 120.0,
                        width: (MediaQuery.of(context).size.width - 32) / 3)),
              ],
            );
          }
        });
  }

  buildHomeMenuRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CategoryList(
                is_top_category: true,
              );
            }));
          },
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/top_categories.png"),
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "Top Categories",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Filter(
                selected_filter: "brands",
              );
            }));
          },
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/brands.png"),
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Brands",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TopSellingProducts();
            }));
          },
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/top_sellers.png"),
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Top Sellers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TodaysDealProducts();
            }));
          },
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/todays_deal.png"),
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Todays Deal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FlashDealList();
            }));
          },
          child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/flash_deal.png"),
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Flash Deal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildHomeCarouselSlider(context) {
    return FutureBuilder(
        future: SlidersRepository().getSliders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            /*print("Home slider error");
            print(snapshot.error.toString());*/
            return Container();
          } else if (snapshot.hasData) {
            dynamic sliderResponse = snapshot.data;
            var carouselImageList = [];
            sliderResponse.sliders.forEach((slider) {
              carouselImageList.add(slider.photo);
            });
            return CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2.67,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.easeInCubic,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current_slider = index;
                    });
                  }),
              items: carouselImageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/placeholder_rectangle.png',
                                  image: AppConfig.BASE_PATH + i,
                                  fit: BoxFit.fill,
                                ))),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: carouselImageList.map((url) {
                              int index = carouselImageList.indexOf(url);
                              return Container(
                                width: 7.0,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current_slider == index
                                      ? MyTheme.white
                                      : const Color.fromRGBO(112, 112, 112, .3),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Shimmer.fromColors(
                baseColor: MyTheme.shimmer_base,
                highlightColor: MyTheme.shimmer_highlighted,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            );
          }
        });
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: MyTheme.splash_screen_color,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: widget.show_back_button
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.white,
                    ),
                  ),
                ),
              ),
      ),
//       title: Container(
//           decoration: BoxDecoration(
//             color: MyTheme.splash_screen_color,
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           child: Column(
//             children: <Widget>[
//               InkWell(
//                 onTap: () async {
// //                   LocationResult result = await showLocationPicker(
// //                     context,
// //                     MAP_API_KEY_ROUTE,
// //                     automaticallyAnimateToCurrentLocation: true,
// // //                      mapStylePath: 'assets/mapStyle.json',
// //                     myLocationButtonEnabled: true,
// //                     requiredGPS: true,
// //                     layersButtonEnabled: true,
// //                     desiredAccuracy: LocationAccuracy.best,
// //                     countries: ['IN'],
// //                     resultCardAlignment: Alignment.bottomCenter,
// //                   );
// //                   setState(() => {
// //                         _getSelectedAddressFromLatLng(
// //                             result.latLng.latitude, result.latLng.longitude)
// //                       });
//                 },
//                 child: Row(
//                   children: <Widget>[
//                     // Icon(
//                     //   Icons.location_on,
//                     //   color: Colors.white,
//                     //   size: 18,
//                     // ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           // Text(
//                           //   'Location',
//                           //   style: TextStyle(color: Colors.white, fontSize: 11),
//                           // ),
//                           // Text(_currentAddress,
//                           /////////////////////////////////
//                           Text("Home",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
      centerTitle: true,
      title: Text(
        "Home",
        style: TextStyle(fontSize: 16, color: MyTheme.white),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 5.0, right: 5),
            child: IconButton(
                icon: Image.asset(
                  'assets/square_logo.png',
                ),
                tooltip: 'Action',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return Filter(
                  //     selected_filter: "sellers",
                  //   );
                  // }));
                })),
        InkWell(
          onTap: () {
            ToastComponent.showDialog("Coming soon", context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // buildHomeSearchBox(BuildContext context) {
  //   return TextField(
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return Filter();
  //       }));
  //     },
  //     autofocus: false,
  //     decoration: InputDecoration(
  //         hintText: "Search",
  //         hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
  //           borderRadius: const BorderRadius.all(
  //             const Radius.circular(16.0),
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: MyTheme.textfield_grey, width: 1.0),
  //           borderRadius: const BorderRadius.all(
  //             const Radius.circular(16.0),
  //           ),
  //         ),
  //         prefixIcon: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Icon(
  //             Icons.search,
  //             color: MyTheme.textfield_grey,
  //             size: 20,
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.all(0.0)),
  //   );
  // }
}
