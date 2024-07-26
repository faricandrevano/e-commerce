import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/product_bloc/product_bloc.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/pages/product_all_page.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_button.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_category_list.dart';
// import 'package:kelompok9_toko_online/ui/widgets/custom_slider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];
  String? selectedCategory;
  void onCategoryChanged(String category) {
    selectedCategory = category;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: whiteColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: mainText,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: blackColorStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (context) =>
                                    _custombottomSheetFilter(context));
                          });
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: mainText,
                        )),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 50,
              child: TextFormField(
                onEditingComplete: () {
                  previousSearchs.add(searchController.text);
                  context
                      .read<ProductBloc>()
                      .add(SearchProducts(title: searchController.text));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductAllPage(),
                    ),
                  );
                },
                controller: searchController,
                onChanged: (pure) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const Icon(
                            Icons.cancel_sharp,
                          ),
                        ),
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search Product Name',
                  hintStyle:
                      const TextStyle(fontSize: 14, color: Color(0xFFC4C5C4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Last Searched',
                style: blackColorStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ),
            // Previous Searches
            Container(
              color: Colors.white,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: previousSearchs.length,
                itemBuilder: (context, index) => previousSearchsItem(index),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ));
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.history,
                color: secondaryText,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                previousSearchs[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: mainText),
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: secondaryText,
              )
            ],
          ),
        ),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add a Filter",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          CustomCategoryList(
            onCategoryChanged: onCategoryChanged,
          ),
          // const CustomSlider(),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                color: form,
                textColor: mainText,
              )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                onTap: () {
                  context.read<ProductBloc>().add(SearchProducts(
                      title: searchController.text,
                      category: selectedCategory));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductAllPage(),
                    ),
                  );
                },
                text: "Done",
              ))
            ],
          )
        ],
      ),
    );
  }
}
