import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ulastir/ui/designer.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField(
      {super.key,
      this.mainPageWidth = false,
      this.defaultValue = '',
      required this.enabled,
      required this.items,
      required this.onSelected,
      required this.hintText,
      required this.icon});

  final bool mainPageWidth;
  final String defaultValue;
  final bool enabled;
  final String hintText;
  final IconData icon;
  final List<String> items;
  final Function(int) onSelected;

  @override
  State<AutoCompleteTextField> createState() => AutoCompleteTextFieldState();
}

class AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  bool enabled2 = true;

  @override
  initState() {
    enabled2 = widget.enabled;
    super.initState();
  }

  setEnabled(bool enabled) {
    setState(() {
      enabled2 = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (textEditingValue) => widget.items.where((element) =>
          element.contains(textEditingValue.text.trim().toUpperCase())),
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          enabled: enabled2,
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          style: TextStyle(color: Designer.textColor),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  color: Designer.darkMode ? Colors.white : Colors.indigo),
            ),
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 200,
                  maxWidth: MediaQuery.of(context).size.width *
                      (widget.mainPageWidth ? 0.88 : 0.94)),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        decoration: BoxDecoration(
                            color:
                                highlight ? Theme.of(context).focusColor : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(option),
                          style: TextStyle(color: Designer.textColor),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: ((option) {
        widget.onSelected(widget.items.indexOf(option));
      }),
    );
  }
}
