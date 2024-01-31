part of app_inputs;

class KeyValue<T> {
  final String key;
  final T value;
  final String search;

  KeyValue({
    required this.key,
    required this.value,
    this.search = "",
  });
}

class AppDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final String? validatorIsRequired;
  final void Function(T?)? onChanged;
  final List<KeyValue<T>> items;
  final String searchText;
  final TextEditingController? controller;

  const AppDropdownButtonFormField({
    required this.items,
    required this.value,
    required this.hint,
    this.controller,
    this.validatorIsRequired,
    this.onChanged,
    this.searchText = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final parameters = AppInputParameters(
      hintText: hint,
      controller: controller,
    );
    return DropdownButtonFormField2<T>(
      value: value,
      isExpanded: true,
      decoration: parameters._defaultDecoration(),
      items: items.map((e) {
        return DropdownMenuItem(value: e.value, child: Text(e.key));
      }).toList(),
      validator: (value) {
        if (value == null && validatorIsRequired != null) {
          return validatorIsRequired;
        }

        return null;
      },
      selectedItemBuilder: (_) => items.map((item) {
        return Text(
          item.key,
          maxLines: 1,
          style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      dropdownSearchData: _searchInput(parameters.controller),
      dropdownStyleData: DropdownStyleData(
        elevation: 8,
        width: 350,
        openInterval: const Interval(0, 0),
        isOverButton: false,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        maxHeight: 300,
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      ),
      //onChanged: onChanged,
      onChanged: (T? value) {
        if (onChanged != null) {
          onChanged!.call(value);
        }
      },
      iconStyleData: const IconStyleData(
        iconSize: 24,
        icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
      ),
      style: const TextStyle(color: Colors.black),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.all(0.0),
      ),
    );
  }

  DropdownSearchData<T>? _searchInput(TextEditingController? controller) {
    if (controller == null) return null;

    return DropdownSearchData(
      searchController: controller,
      searchInnerWidgetHeight: 50,
      searchInnerWidget: Container(
        height: 50,
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 4,
          right: 8,
          left: 8,
        ),
        child: TextFormField(
          expands: true,
          maxLines: null,
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            hintText: searchText,
            hintStyle: const TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        final current = items.firstWhere((e) => e.value == item.value);
        final value = current.search.toLowerCase();
        return value.contains(searchValue.toLowerCase());
      },
    );
  }
}
