import 'package:data_table/features/bulkProductUpload/data/models/bulk_product_model.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/custom_scroll_view.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/table_header.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BulkProductUploadPage extends StatefulWidget {
  const BulkProductUploadPage({super.key});

  @override
  State<BulkProductUploadPage> createState() => _BulkProductUploadPageState();
}

class _BulkProductUploadPageState extends State<BulkProductUploadPage> {
  bool isAscending = false;

  @override
  initState() {
    super.initState();
    BlocProvider.of<BulkProductUploadCubit>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Data Table'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TableHeader(),
            CustomScroll(
              child:
                  BlocBuilder<BulkProductUploadCubit, BulkProductUploadState>(
                      builder: (context, state) {
                if (state is BulkProductUploadInitial) {
                  return const Placeholder();
                } else if (state is BulkProductUploadLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BulkProductUploadLoaded) {
                  return DataTable(
                      // horizontalMargin: 0,
                      showBottomBorder: true,
                      showCheckboxColumn: true,
                      sortAscending: isAscending,
                      onSelectAll: (val) {
                        BlocProvider.of<BulkProductUploadCubit>(context)
                            .toggleSelectAll();
                      },
                      // border: TableBorder.all(width: 1.0, color: Colors.red),
                      columns: getColumns(
                          ProductColumns.values.map((e) => e.name).toList(),
                          state.products),
                      rows: getRows(state.products));
                }
                return const Placeholder();
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumns(
      List<String> columns, List<BulkProductModel> products) {
    return columns
        .map((columnName) => DataColumn(
              numeric: columnName == ProductColumns.buyingPrice.name ||
                  columnName == ProductColumns.sellingPrice.name ||
                  columnName == ProductColumns.quantity.name,
              onSort: (columnIndex, ascending) {
                setState(() {
                  products.sort((a, b) => isAscending
                      ? a.buyingPrice.compareTo(b.buyingPrice)
                      : b.buyingPrice.compareTo(a.buyingPrice));
                  isAscending = !isAscending;
                });
              },
              label: Expanded(
                child: Row(
                  children: [
                    Text(
                      '${columnName[0].toUpperCase()}${columnName.substring(1)}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Icon(
                        isAscending ? Icons.arrow_downward : Icons.arrow_upward)
                  ],
                ),
              ),
            ))
        .toList();
  }

  List<DataRow> getRows(List<BulkProductModel> products) {
    return products.map((product) {
      final cells = [
        product.productName,
        product.quantity,
        product.buyingPrice,
        product.sellingPrice
      ];

      return DataRow(
        selected: product.isSelected,
        onSelectChanged: (value) {
          BlocProvider.of<BulkProductUploadCubit>(context)
              .toggleSelectedProduct(product);
        },
        cells: Utils.modelBuilder(
            cells, (index, model) => DataCell(Text(model.toString()))).toList(),
      );
    }).toList();
  }
}
