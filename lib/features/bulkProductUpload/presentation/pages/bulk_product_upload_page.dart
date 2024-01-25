import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/is_ascending_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/custom_dialog.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/custom_scroll_view.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/table_header.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BulkProductUploadPage] page that displays a [DataTable]
class BulkProductUploadPage extends StatefulWidget {
  /// [BulkProductUploadPage] constructor
  const BulkProductUploadPage({super.key});

  @override
  State<BulkProductUploadPage> createState() => _BulkProductUploadPageState();
}

class _BulkProductUploadPageState extends State<BulkProductUploadPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BulkProductUploadCubit>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final isAscending = context.watch<IsAscendingCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Data Table'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TableHeader(),
              BlocBuilder<BulkProductUploadCubit, BulkProductUploadState>(
                builder: (context, state) {
                  if (state is BulkProductUploadInitial) {
                    return const Placeholder();
                  } else if (state is BulkProductUploadLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BulkProductUploadLoaded) {
                    return CustomScroll(
                      child: DataTable(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        showBottomBorder: true,
                        columnSpacing: 28,
                        horizontalMargin: 12,
                        sortAscending: isAscending,
                        onSelectAll: (val) {
                          BlocProvider.of<BulkProductUploadCubit>(context)
                              .toggleSelectAll();
                        },
                        columns: getColumns(
                          columns:
                              ProductColumns.values.map((e) => e.name).toList(),
                          products: state.products,
                          isAscending: isAscending,
                        ),
                        rows: getRows(state.products),
                      ),
                    );
                  }
                  return const Placeholder();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> getColumns({
    required List<String> columns,
    required List<BulkProductModel> products,
    required bool isAscending,
  }) {
    return Utils.modelBuilder(
      columns,
      (index, columnName) => DataColumn(
        numeric: columnName == ProductColumns.buyingPrice.name ||
            columnName == ProductColumns.sellingPrice.name,
        onSort: (columnIndex, ascending) {
          BlocProvider.of<BulkProductUploadCubit>(context).sortColumn(
            isAscending: isAscending,
            ProductColumns.values[columnIndex],
          );
          BlocProvider.of<IsAscendingCubit>(context).toggle();
        },
        label: Expanded(
          child: Row(
            children: [
              Text(
                getColumnName(ProductColumns.values[index]),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Icon(
                isAscending ? Icons.arrow_downward : Icons.arrow_upward,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> getRows(List<BulkProductModel> products) {
    return products.map((product) {
      final cells = [
        product.productName,
        product.quantity,
        product.buyingPrice,
        product.sellingPrice,
      ];

      return DataRow(
        selected: product.isSelected,
        onSelectChanged: (value) {
          BlocProvider.of<BulkProductUploadCubit>(context)
              .toggleSelectedProduct(product);
        },
        cells: Utils.modelBuilder(
          cells,
          (index, model) => DataCell(
            Text(model.toString()),
            showEditIcon: index == ProductColumns.productName.index ||
                index == ProductColumns.quantity.index,
            onTap: () async {
              final updatedProduct = await updateProductDialog(
                context: context,
                hintText: cells[index].toString(),
                product: product,
                cellIndex: index,
              );

              if (updatedProduct != null && context.mounted) {
                BlocProvider.of<BulkProductUploadCubit>(context)
                    .updateProduct(updatedProduct);
              }
            },
          ),
        ).toList(),
      );
    }).toList();
  }
}
