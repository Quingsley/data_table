import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/data/models/product_category_model.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/categories_cubit.dart';

import 'package:data_table/features/bulkProductUpload/presentation/widgets/add_product_dialog.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/menu_pop_up.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

/// [TableHeader] is a [StatefulWidget] that displays
/// the header of the [PlutoGrid] with various menu options
class TableHeader extends StatefulWidget {
  /// constructor for [TableHeader]
  const TableHeader({required this.stateManager, super.key});

  /// pluto state manager
  final PlutoGridStateManager stateManager;

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoriesCubit>().state;
    final products = context.watch<BulkProductUploadCubit>().products;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(4),
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: 'Search By Product Name',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (searchTerm) {
                    // reset the state if the search term is empty after search

                    if (searchTerm.trim().isEmpty) {
                      // will get initial products from the state
                      final products =
                          context.read<BulkProductUploadCubit>().products;
                      widget.stateManager.removeAllRows();
                      widget.stateManager.appendRows(
                        products
                            .map(
                              addProductsToRow,
                            )
                            .toList(),
                      );
                    }
                    if (searchTerm.trim().isNotEmpty) {
                      setState(() {
                        widget.stateManager.removeRows(
                          searchProduct(
                            searchTerm,
                            widget.stateManager,
                            context,
                          ),
                        );
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomMenuPopUp(
              menuChildren: categories
                  .map(
                    (c) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(c.name.toUpperCase()),
                      children: c.subCategories
                          .map(
                            (subCategory) => CheckboxListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(
                                '${subCategory.name[0].toUpperCase()}${subCategory.name.substring(1)}',
                              ),
                              value: subCategory.isSelected,
                              onChanged: (value) {
                                BlocProvider.of<CategoriesCubit>(context)
                                    .toggleSubCategories(subCategory);
                                if (value != null) {
                                  BlocProvider.of<BulkProductUploadCubit>(
                                    context,
                                  ).filterProducts(
                                    subCategory,
                                    isSelected: value,
                                  );
                                  setState(() {
                                    widget.stateManager.removeAllRows();
                                    widget.stateManager.appendRows(
                                      filterProducts(
                                        products,
                                        subCategory,
                                        isSelected: value,
                                      ),
                                    );
                                  });

                                  if (value == false) {
                                    // add back the whole  products back
                                    //to the state
                                    BlocProvider.of<BulkProductUploadCubit>(
                                      context,
                                    ).reset();
                                    widget.stateManager.removeAllRows();
                                    widget.stateManager.appendRows(
                                      products
                                          .map(
                                            addProductsToRow,
                                          )
                                          .toList(),
                                    );
                                  }
                                }
                              },
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
              title: 'Categories',
              icon: Icons.filter_list,
              label: 'Filters',
            ),
            const SizedBox(width: 4),
            CustomMenuPopUp(
              menuChildren: [
                ...uiColumns.map(
                  (column) => CheckboxListTile(
                    title: Text(column.title),
                    value: column.hide,
                    onChanged: (val) {
                      setState(() {
                        widget.stateManager.hideColumn(column, !column.hide);
                      });
                    },
                  ),
                ),
              ],
              title: 'Show Columns',
              icon: Icons.visibility,
              label: 'Columns',
            ),
            const SizedBox(width: 4),
            OutlinedButton.icon(
              onPressed: () async {
                final newProduct = await addNewProduct(context: context);
                if (newProduct != null && context.mounted) {
                  BlocProvider.of<BulkProductUploadCubit>(context)
                      .addProduct(newProduct);
                  widget.stateManager
                      .appendRows([addProductsToRow(newProduct)]);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('add'),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

/// used to return a list of products that are not found
/// after a search and then remove them from the state
List<PlutoRow> searchProduct(
  String searchTerm,
  PlutoGridStateManager stateManager,
  BuildContext context,
) {
  var notFoundProducts = <PlutoRow>[];
  if (searchTerm.trim().isNotEmpty) {
    notFoundProducts = stateManager.rows
        .where(
          (row) => !(row.cells['productName']?.value as String)
              .toLowerCase()
              .contains(searchTerm.toLowerCase()),
        )
        .toList();
  }
  return notFoundProducts;
}

/// filter products based on the subcategory and the value
/// then return a list of [PlutoRow] to be added to the state
List<PlutoRow> filterProducts(
  List<BulkProductModel> products,
  ProductSubCategory subCategory, {
  required bool isSelected,
}) {
  final selectedProducts = products
      .where(
    (product) => product.category.subCategories.contains(subCategory),
  )
      .map((c) {
    final newSubCategories = c.category.subCategories.map((sub) {
      if (sub.id == subCategory.id) {
        return sub.copyWith(isSelected: isSelected);
      }
      return sub;
    }).toList();
    final newCategories = c.category.copyWith(
      subCategories: newSubCategories,
    );
    return c.copyWith(category: newCategories);
  }).toList();
  return selectedProducts
      .map(
        addProductsToRow,
      )
      .toList();
}
