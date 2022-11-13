import 'package:flutter/material.dart';

import '../helpers/shimmer_helper.dart';
import '../helpers/string_helper.dart';
import '../my_theme.dart';
import '../repositories/product_repository.dart';
import '../ui_elements/product_card.dart';

class FlashDealProducts extends StatefulWidget {
  const FlashDealProducts({Key? key, this.flash_deal_id, this.flash_deal_name})
      : super(key: key);
  final int? flash_deal_id;
  final String? flash_deal_name;

  @override
  _FlashDealProductsState createState() => _FlashDealProductsState();
}

class _FlashDealProductsState extends State<FlashDealProducts> {
  final TextEditingController _searchController = TextEditingController();

  Future<dynamic>? _future;

  List<dynamic>? _searchList;
  List<dynamic>? _fullList;
  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _future =
        ProductRepository().getFlashDealProducts(id: widget.flash_deal_id!);
    _searchList = [];
    _fullList = [];
    super.initState();
  }

  _buildSearchList(searchKey) async {
    _searchList?.clear();
    print(_fullList?.length);

    if (searchKey.isEmpty) {
      _searchList?.addAll(_fullList!);
      setState(() {});
      //print("_searchList.length on empty " + _searchList.length.toString());
      //print("_fullList.length on empty " + _fullList.length.toString());
    } else {
      for (var i = 0; i < _fullList!.length; i++) {
        if (StringHelper().stringContains(_fullList![i].name, searchKey)) {
          _searchList?.add(_fullList![i]);
          setState(() {});
        }
      }

      //print("_searchList.length with txt " + _searchList.length.toString());
      //print("_fullList.length with txt " + _fullList.length.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildProductList(context),
    );
  }

  bool shouldProductBoxBeVisible(productName, searchKey) {
    if (searchKey == "") {
      return true; //do not check if the search key is empty
    }
    return StringHelper().stringContains(productName, searchKey);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      /*bottom: PreferredSize(
          child: Container(
            color: MyTheme.textfield_grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0)),*/
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: SizedBox(
          width: 250,
          child: TextField(
            controller: _searchController,
            onChanged: (txt) {
              print(txt);
              _buildSearchList(txt);
              // print(_searchList.toString());
              // print(_searchList.length);
            },
            onTap: () {},
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Search products from : ${widget.flash_deal_name!}",
                hintStyle:
                    TextStyle(fontSize: 14.0, color: MyTheme.textfield_grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyTheme.white, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyTheme.white, width: 0.0),
                ),
                contentPadding: const EdgeInsets.all(0.0)),
          )),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.search, color: MyTheme.dark_grey),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  buildProductList(context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //snapshot.hasError
            //print("product error");
            //print(snapshot.error.toString());
            return Container();
          } else if (snapshot.hasData) {
            dynamic productResponse = snapshot.data;
            if (_fullList!.isEmpty) {
              _fullList?.addAll(productResponse.products);
              _searchList?.addAll(productResponse.products);
              //print('xcalled');
            }

            //print('called');

            return SingleChildScrollView(
              child: GridView.builder(
                // 2
                //addAutomaticKeepAlives: true,
                itemCount: _searchList!.length,
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.578),
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // 3
                  return ProductCard(
                    id: _searchList![index].id,
                    image: _searchList![index].thumbnail_image,
                    name: _searchList![index].name,
                    price: _searchList![index].base_price,
                  );
                },
              ),
            );
          } else {
            return ShimmerHelper()
                .buildProductGridShimmer(scontroller: _scrollController);
          }
        });
  }
}
