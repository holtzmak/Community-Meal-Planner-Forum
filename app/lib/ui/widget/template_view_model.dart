import 'package:app/service/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {}

class TemplateViewModel<T extends ViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  TemplateViewModel({required this.builder, this.onModelReady});

  @override
  _TemplateViewModelState<T> createState() => _TemplateViewModelState<T>();
}

class _TemplateViewModelState<T extends ViewModel>
    extends State<TemplateViewModel<T>> {
  T model = ServiceLocator.get<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
