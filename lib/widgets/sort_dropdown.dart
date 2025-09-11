import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/screens/product_list/bloc/product_list_bloc.dart';

class SortDropdown extends StatefulWidget {
  const SortDropdown({super.key});

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String? selectedValue;

  final Map<String, String> options = {
    ProductSortRoutes.newestProducts: 'جدیدترین',
    ProductSortRoutes.cheapestProducts: 'ارزان‌ترین',
    ProductSortRoutes.mostExpensiveProducts: 'گران‌ترین',
    ProductSortRoutes.mostViewedProducts: 'پربازدیدترین',
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      dropdownColor: AppColors.mainBg,
      alignment: Alignment.centerRight,
      hint: Text('بدون فیلتر', style: LightAppTextStyle.title),
      underline: const SizedBox.shrink(),
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: SvgPicture.asset(Assets.svg.sort, height: 20),
      ),
      items: options.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(entry.value, style: LightAppTextStyle.title),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          selectedValue = value;
        });
        context.read<ProductListBloc>().add(
          ProductSortedListEvent(routeParam: value),
        );
      },
    );
  }
}
