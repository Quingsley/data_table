import 'package:data_table/features/bulkProductUpload/presentation/cubit/bulk_product_upload_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/is_ascending_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/cubit/selected_columns_cubit.dart';
import 'package:data_table/features/bulkProductUpload/presentation/pages/bulk_product_upload_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

/// [MainApp] is the entry point of the application
class MainApp extends StatelessWidget {
  /// [MainApp] constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bulk Product Upload',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BulkProductUploadCubit>(
            create: (_) => BulkProductUploadCubit(),
          ),
          BlocProvider(
            create: (_) => IsAscendingCubit(),
          ),
          BlocProvider(
            create: (_) => ColumnsCubit(),
          ),
        ],
        child: const BulkProductUploadPage(),
      ),
    );
  }
}
