import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/enjoy_bar.dart';
import '../../../../card/presentation/managers/carts_cubit.dart';
import '../../../../favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import '../../managers/products_cubit/products_cubit.dart';
import 'banner_section.dart';
import 'categories_tap_products_section.dart';
import 'categories_taps_section.dart';
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  static bool isElectronicDevices = true;
  static bool isPreventCorona = false;
  static bool isSports = false;
  static bool isLighting = false;
  static bool isClothes = false;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    var bannersCubit = BlocProvider.of<BannerCubit>(context);
    var categoriesCubit = BlocProvider.of<CategoriesCubit>(context)..getCategoryProducts(categoryId: 44);
     var productsCubit = BlocProvider.of<ProductsCubit>(context);
    var favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    var cartsCubit = BlocProvider.of<CartsCubit>(context);
    final pageController = PageController();
    TextEditingController textController = TextEditingController();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.88,
      child: ListView(
        scrollDirection: Axis.vertical,
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          enjoyBar(context, text: 'Enjoy our products',),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SearchTextField(textController: textController, productsCubit: productsCubit, favoritesCubit: favoritesCubit, cartsCubit: cartsCubit)//buildSearchTextFormField(textController, productsCubit, context, favoritesCubit, cartsCubit),
          ),

           SizedBox(
            height: 20.h,
          ),
           Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child:Text(
              'Select Category',
              style: TextStyle(
                color: color4,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CategoriesTaps(categoriesCubit: categoriesCubit) //buildCategoriesNamesListView(categoriesCubit),
          ),
           SizedBox(
            height: 16.h,
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoryProductsSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CategoryTapProductsListView(categoriesCubit: categoriesCubit, favoritesCubit: favoritesCubit, cartsCubit: cartsCubit)
                );
              } else if (state is CategoryProductsFailure) {

                return const Center(child: CustomErrorWidget());
              } else {
                // return const Center(child: CircularProgressIndicator());
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.5,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return  SizedBox(
                          width: 200.w,
                          height: 100.h,
                          child: Shimmer.fromColors(
                            baseColor: color9,
                            highlightColor: color9.withOpacity(0.5,),
                            period: const Duration(milliseconds:500),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18,),color: Colors.grey,),
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                );
              }
            },
          ),
           SizedBox(
            height: 16.h,
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'New Offers And Discounts',
              style: TextStyle(
                color: color4,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           SizedBox(
            height: 10.h,
          ),
          BlocBuilder<BannerCubit, BannerState>(
            builder: (context, state) {
              if (state is BannerSuccess) {
                return BannerSection(pageController: pageController, bannersCubit: bannersCubit);
              } else if (state is BannerFailure) {
                return  SizedBox(height: 150.h, child: const CustomErrorWidget());
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 150.h,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Shimmer.fromColors(
                        baseColor: color9,
                        highlightColor: color9.withOpacity(0.5,),
                        period: const Duration(milliseconds:500),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18,),color: Colors.grey,),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}