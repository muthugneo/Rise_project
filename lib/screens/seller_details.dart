
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../app_config.dart';
import '../helpers/shimmer_helper.dart';
import '../my_theme.dart';
import '../repositories/shop_repository.dart';
import '../ui_elements/list_product_card.dart';
import '../ui_elements/mini_product_card.dart';
import '../ui_elements/product_card.dart';
import 'seller_products.dart';

class SellerDetails extends StatefulWidget {
  int? id;

  SellerDetails({Key? key, this.id}) : super(key: key);

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();

  //init
  int _current_slider = 0;
  final List<dynamic> _carouselImageList = [];
  bool _carouselInit = false;
  var _shopDetails;

  final List<dynamic> _newArrivalProducts = [];
  bool _newArrivalProductInit = false;
  final List<dynamic> _topProducts = [];
  bool _topProductInit = false;
  final List<dynamic> _featuredProducts = [];
  bool _featuredProductInit = false;

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchAll() {
    fetchProductDetails();
    fetchNewArrivalProducts();
    fetchTopProducts();
    fetchFeaturedProducts();
  }

  fetchProductDetails() async {
    var shopDetailsResponse = await ShopRepository().getShopInfo(id: widget.id);

    //print('ss:' + shopDetailsResponse.toString());
    if (shopDetailsResponse.shops!.isNotEmpty) {
      _shopDetails = shopDetailsResponse.shops![0];
    }

    if (_shopDetails != null) {
      _shopDetails.sliders.forEach((slider) {
        _carouselImageList.add(slider);
      });
    }
    _carouselInit = true;

    setState(() {});
  }

  fetchNewArrivalProducts() async {
    var newArrivalProductResponse =
        await ShopRepository().getNewFromThisSellerProducts(id: widget.id!);
    _newArrivalProducts.addAll(newArrivalProductResponse.products!);
    _newArrivalProductInit = true;

    setState(() {});
  }

  fetchTopProducts() async {
    var topProductResponse =
        await ShopRepository().getTopFromThisSellerProducts(id: widget.id!);
    _topProducts.addAll(topProductResponse.products!);
    _topProductInit = true;
  }

  fetchFeaturedProducts() async {
    var featuredProductResponse =
        await ShopRepository().getfeaturedFromThisSellerProducts(id: widget.id!);
    _featuredProducts.addAll(featuredProductResponse.products!);
    _featuredProductInit = true;
  }

  reset() {
    _shopDetails = null;
    _carouselImageList.clear();
    _carouselInit = false;
    _newArrivalProducts.clear();
    _topProducts.clear();
    _featuredProducts.clear();
    _topProductInit = false;
    _newArrivalProductInit = false;
    _featuredProductInit = false;
    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        bottomNavigationBar: buildBottomAppBar(context),
        body: RefreshIndicator(
          color: MyTheme.accent_color,
          backgroundColor: Colors.white,
          onRefresh: _onPageRefresh,
          child: CustomScrollView(
            controller: _mainScrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                      0.0,
                    ),
                    child: buildCarouselSlider(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                      0.0,
                    ),
                    child: Text(
                      "New Arrivals",
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8.0,
                      16.0,
                      0.0,
                      0.0,
                    ),
                    child: buildNewArrivalList(),
                  )
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                      0.0,
                    ),
                    child: Text(
                      "Top Selling Products",
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                      0.0,
                    ),
                    child: buildTopSellingProductList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                      0.0,
                    ),
                    child: Text(
                      "Featured Products",
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        16.0,
                        0.0,
                      ),
                      child: buildfeaturedProductList())
                ]),
              )
            ],
          ),
        ));
  }

  buildfeaturedProductList() {
    if (_featuredProductInit == false && _featuredProducts.isEmpty) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildProductGridShimmer(scontroller: _scrollController));
    } else if (_featuredProducts.isNotEmpty) {
      return GridView.builder(
        // 2
        //addAutomaticKeepAlives: true,
        itemCount: _featuredProducts.length,
        //controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.588),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // 3
          return ProductCard(
            id: _featuredProducts[index].id,
            image: _featuredProducts[index].thumbnail_image,
            name: _featuredProducts[index].name,
            price: _featuredProducts[index].base_price,
          );
        },
      );
    } else {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text("No featured product is available from this seller",
                  style: TextStyle(color: MyTheme.font_grey))));
    }
  }

  buildCarouselSlider(context) {
    if (_shopDetails == null) {
      return ShimmerHelper().buildBasicShimmer(
        height: 190.0,
      );
    } else if (_carouselImageList.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 3.2,
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
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Stack(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder_rectangle.png',
                            image: AppConfig.BASE_PATH + i,
                            fit: BoxFit.fill,
                          ))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _carouselImageList.map((url) {
                        int index = _carouselImageList.indexOf(url);
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
      return Container();
    }
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shopDetails != null
                ? buildShowProductsButton(context)
                : Container()
          ],
        ),
      ),
    );
  }

  buildShowProductsButton(BuildContext context) {
    return FlatButton(
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
      color: MyTheme.accent_color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: const Text(
        "View All Products From This Seller",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SellerProducts(
            id: _shopDetails.id,
            shop_name: _shopDetails.name,
          );
        }));
      },
    );
  }

  buildTopSellingProductList() {
    if (_topProductInit == false && _topProducts.isEmpty) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
        ],
      );
    } else if (_topProducts.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _topProducts.length,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: ListProductCard(
                id: _topProducts[index].id,
                image: _topProducts[index].thumbnail_image,
                name: _topProducts[index].name,
                price: _topProducts[index].base_price,
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text("No top selling products from this seller",
                  style: TextStyle(color: MyTheme.font_grey))));
    }
  }

  buildNewArrivalList() {
    if (_newArrivalProductInit == false && _newArrivalProducts.isEmpty) {
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
    } else if (_newArrivalProducts.isNotEmpty) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 175,
          child: ListView.builder(
            itemCount: _newArrivalProducts.length,
            scrollDirection: Axis.horizontal,
            itemExtent: 120,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: MiniProductCard(
                  id: _newArrivalProducts[index].id,
                  image: _newArrivalProducts[index].thumbnail_image,
                  name: _newArrivalProducts[index].name,
                  price: _newArrivalProducts[index].base_price,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text(
            "No new arrivals",
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Container(
        child: SizedBox(
            width: 350,
            child: _shopDetails != null
                ? buildAppbarShopDetails()
                : Row(
                    children: [
                      ShimmerHelper()
                          .buildBasicShimmer(height: 60.0, width: 60.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerHelper()
                                .buildBasicShimmer(height: 25.0, width: 150.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ShimmerHelper().buildBasicShimmer(
                                  height: 20.0, width: 100.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.location_on, color: MyTheme.dark_grey),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: const EdgeInsets.only(
                            top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                            _shopDetails.address,
                            maxLines: 3,
                            style: TextStyle(
                                color: MyTheme.font_grey, fontSize: 14),
                          ),
                        ),
                        actions: [
                          FlatButton(
                            child: Text(
                              "CLOSE",
                              style: TextStyle(color: MyTheme.medium_grey),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
            },
          ),
        ),
      ],
    );
  }

  buildAppbarShopDetails() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: const Color.fromRGBO(112, 112, 112, .3), width: .5),
          //shape: BoxShape.rectangle,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
              image: AppConfig.BASE_PATH + _shopDetails.logo,
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                _shopDetails.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color: MyTheme.font_grey,
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: buildRatingWithCountRow(),
            ),
          ],
        ),
      ),
    ]);
  }

  Row buildRatingWithCountRow() {
    return Row(
      children: [
        RatingBar(
          itemSize: 14.0,
          ignoreGestures: true,
          initialRating: double.parse(_shopDetails.rating.toString()),
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: const Icon(FontAwesome.star, color: Colors.amber),
            empty:
                const Icon(FontAwesome.star, color: Color.fromRGBO(224, 224, 225, 1)), half: const SizedBox(),
          ),
          itemPadding: const EdgeInsets.only(right: 4.0),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }
}