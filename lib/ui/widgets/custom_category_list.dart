import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class CustomCategoryList extends StatefulWidget {
  const CustomCategoryList({super.key, required this.onCategoryChanged});
  final ValueChanged<String> onCategoryChanged;

  @override
  State<CustomCategoryList> createState() => _CustomCategoryListState();
}

class _CustomCategoryListState extends State<CustomCategoryList> {
  int _index = 0;
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              menuButton(
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                  color: _index == 0 ? primary : form,
                  text: "All",
                  textColor: _index == 0 ? Colors.white : secondaryText,
                  width: _index == 0 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      selectedCategory = 'electronics';
                      _index = 1;
                    });
                    widget.onCategoryChanged(selectedCategory!);
                  },
                  color: _index == 1 ? primary : form,
                  text: "electronics",
                  textColor: _index == 1 ? Colors.white : secondaryText,
                  width: _index == 1 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      selectedCategory = 'jewelery';
                      _index = 2;
                    });
                    widget.onCategoryChanged(selectedCategory!);
                  },
                  color: _index == 2 ? primary : form,
                  text: "jewelery",
                  textColor: _index == 2 ? Colors.white : secondaryText,
                  width: _index == 2 ? 85 : 85),
              menuButton(
                  onTap: () {
                    setState(() {
                      selectedCategory = "men's clothing";
                      _index = 3;
                    });
                    widget.onCategoryChanged(selectedCategory!);
                  },
                  color: _index == 3 ? primary : form,
                  text: "men's clothing",
                  textColor: _index == 3 ? Colors.white : secondaryText,
                  width: _index == 3 ? 95 : 95),
              menuButton(
                  onTap: () {
                    setState(() {
                      selectedCategory = "women's clothing";
                      _index = 4;
                    });
                    widget.onCategoryChanged(selectedCategory!);
                  },
                  color: _index == 4 ? primary : form,
                  text: "women's clothing",
                  textColor: _index == 4 ? Colors.white : secondaryText,
                  width: _index == 4 ? 95 : 95),
            ],
          ),
        ),
      ],
    );
  }

  menuButton(
      {required String text,
      required Color color,
      required Color textColor,
      required double width,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
