import 'package:e_commerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ScrollController _scrollController = ScrollController();

  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_loadMore);
    });
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter < 400) {
      _categoryController.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Categories"),
          leading: BackButton(onPressed: _backToHome),
        ),
        body: GetBuilder(
          init: _categoryController,
          builder: (_) {
            if (_categoryController.isInitialLoading) {
              return CenterCicularProgress();
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _categoryController.refreshCategories();
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _categoryController.categorieList.length,
                        itemBuilder: (context, index) {
                          return FittedBox(
                            child: ProductCategoriesItem(
                              categoryModel:
                                  _categoryController.categorieList[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _categoryController.getCategoryInProgress,
                    child: LinearProgressIndicator(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainNavbarController>().backToHome();
  }
}
