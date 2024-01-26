import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/categories_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/columns_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/ui_app_states_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/menu_pop_up.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [TableHeader] is a [StatelessWidget] that displays
/// the header of the [DataTable] with various menu options
class TableHeader extends StatelessWidget {
  /// constructor for [TableHeader]
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = context.watch<ColumnsCubit>();
    final showCheckBoxColumn = context.watch<CheckBoxSelectionCubit>().state;
    // final products = context.read<BulkProductUploadCubit>().products;
    final categories = context.watch<CategoriesCubit>().state;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                                    if (value == false) {
                                      // add back the whole  products back
                                      //to the state
                                      BlocProvider.of<BulkProductUploadCubit>(
                                        context,
                                      ).reset();
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
              CustomMenuPopUp(
                menuChildren: [
                  ...columns.state.map(
                    (column) => CheckboxListTile(
                      title: Text(getColumnName(column.name)),
                      value: column.isVisible,
                      enabled:
                          // prevents from having columns < 1
                          column.name != ProductColumnsEnum.productName.name,
                      onChanged: (_) {
                        BlocProvider.of<ColumnsCubit>(context)
                            .toggleColumn(column);
                      },
                    ),
                  ),
                  CheckboxListTile(
                    value: showCheckBoxColumn,
                    onChanged: (_) {
                      BlocProvider.of<CheckBoxSelectionCubit>(context).toggle();
                    },
                    title: const Text('Checkbox Selection'),
                  ),
                ],
                title: 'Show Columns',
                icon: Icons.visibility,
                label: 'Columns',
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
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
                      BlocProvider.of<BulkProductUploadCubit>(context).reset();
                    }
                    if (searchTerm.trim().isNotEmpty) {
                      BlocProvider.of<BulkProductUploadCubit>(context)
                          .searchProductByName(searchTerm);
                    }
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }
}
