import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/widgets/table_header.dart';
import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

/// experimental using the pluto_grid package
class PlutoPage extends StatefulWidget {
  /// [PlutoPage] constructor
  const PlutoPage({super.key});

  @override
  State<PlutoPage> createState() => _PlutoPageState();
}

class _PlutoPageState extends State<PlutoPage> {
  final List<PlutoRow> rows = [];
  final List<PlutoColumn> columns = [];
  @override
  void initState() {
    super.initState();
    columns.addAll(uiColumns);
    Future.delayed(Duration.zero, () async {
      await BlocProvider.of<BulkProductUploadCubit>(context).getProducts();
      if (context.mounted) {
        final products =
            BlocProvider.of<BulkProductUploadCubit>(context).products;
        rows.addAll(
          products
              .map(
                addProductsToRow,
              )
              .toList(),
        );
      }
    });
  }

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 2),
        child: BlocBuilder<BulkProductUploadCubit, BulkProductUploadState>(
          builder: (context, state) {
            if (state is BulkProductUploadLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BulkProductUploadInitial) {
              return const SizedBox.shrink();
            } else if (state is BulkProductUploadLoaded) {
              final products = state.products;
              return Column(
                children: [
                  Expanded(
                    child: PlutoGrid(
                      columns: columns,
                      rows: rows,
                      onRowChecked: (event) {
                        if (event.rowIdx != null) {
                          BlocProvider.of<BulkProductUploadCubit>(context)
                              .toggleSelectedProduct(products[event.rowIdx!]);
                        }
                      },
                      onSelected: print,
                      createHeader: (stateManager) {
                        return TableHeader(
                          stateManager: stateManager,
                        );
                      },
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                      },
                      createFooter: (stateManager) {
                        stateManager.setPageSize(
                          10,
                          notify: false,
                        ); // default 40
                        return PlutoPagination(
                          stateManager,
                        );
                      },
                      onChanged: (event) {
                        final updatedProduct = switch (event.columnIdx) {
                          0 => products[event.rowIdx]
                              .copyWith(productName: event.value.toString()),
                          1 => products[event.rowIdx].copyWith(
                              quantity: int.tryParse(event.value.toString()),
                            ),
                          2 => products[event.rowIdx].copyWith(
                              buyingPrice:
                                  double.tryParse(event.value.toString()),
                            ),
                          3 => products[event.rowIdx].copyWith(
                              sellingPrice:
                                  double.tryParse(event.value.toString()),
                            ),
                          int() => null,
                        };
                        if (updatedProduct != null) {
                          BlocProvider.of<BulkProductUploadCubit>(context)
                              .updateProduct(updatedProduct);
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final rowsToRemove =
                                rows.where((row) => row.checked!).toList();
                            stateManager.removeRows(rowsToRemove);
                            BlocProvider.of<BulkProductUploadCubit>(context)
                                .deleteProduct();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Delete'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
