import 'package:data_table/utils/utils.dart';
import 'package:flutter/material.dart';

/// [TableHeader] is a [StatelessWidget] that displays
/// the header of the [DataTable] with various menu options
class TableHeader extends StatelessWidget {
  /// constructor for [TableHeader]
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                label: const Text('Filter'),
                icon: const Icon(Icons.filter_list),
              ),
              MenuAnchor(
                alignmentOffset: const Offset(0, 5),
                style: const MenuStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(12),
                  ),
                  elevation: MaterialStatePropertyAll<double>(5),
                ),
                menuChildren: [
                  Text('Show Columns'.toUpperCase()),
                  ...ProductColumns.values.map(
                    (column) => CheckboxListTile(
                      title: Text(getColumnName(column)),
                      value: true,
                      onChanged: (bool? value) {},
                    ),
                  ),
                ],
                builder: (context, controller, child) {
                  return OutlinedButton.icon(
                    onPressed: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    label: const Text('Columns'),
                    icon: const Icon(Icons.visibility),
                  );
                },
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
