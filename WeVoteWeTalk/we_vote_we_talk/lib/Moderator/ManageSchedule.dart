import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../Database.dart';
import '../Shared/Idea.dart';

class ManageSchedule extends StatefulWidget {
  ManageSchedule();

  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class ItemData {
  ItemData(this.title, this.key);

  final String title;

  final Key key;
}

enum DraggingMode {
  iOS,
  Android,
}

class _ManageScheduleState extends State<ManageSchedule> {
  List<ItemData> _items;

  _ManageScheduleState() {
    _items = List();
    String label = "Cães - 0 Votes";
    _items.add(ItemData(label, ValueKey(0)));
    label = "Gatos - 1 Votes";
    _items.add(ItemData(label, ValueKey(1)));
  }

  int _indexOfKey(Key key) {
    return _items.indexWhere((ItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = _items[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      _items.removeAt(draggingIndex);
      _items.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = _items[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

  DraggingMode _draggingMode = DraggingMode.iOS;

  Widget build(BuildContext context) {
    return StreamBuilder<List<Idea>>(
        stream: DatabaseService("", "").ideas,
        builder: (context, snapshot) {
          List<Idea> ideas = snapshot.data;
          return Scaffold(
            body: ReorderableList(
              onReorder: this._reorderCallback,
              onReorderDone: this._reorderDone,
              child: CustomScrollView(
                // cacheExtent: 3000,
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text('We Vote We Talk'),
                    backgroundColor: Color(0xFF106799),
                    actions: <Widget>[],
                    pinned: true,
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery
                              .of(context)
                              .padding
                              .bottom),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Item(
                              data: _items[index],
                              // first and last attributes affect border drawn during dragging
                              isFirst: index == 0,
                              isLast: index == _items.length - 1,
                              draggingMode: _draggingMode,
                            );
                          },
                          childCount: _items.length,
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}

class Item extends StatelessWidget {
  Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.draggingMode,
  });

  final ItemData data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Color(0x08000000),
              child: Center(
                child: Icon(Icons.reorder, color: Color(0xFF888888)),
              ),
            ),
          )
        : Container();

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: Text(data.title,
                        style: Theme.of(context).textTheme.subtitle1),
                  )),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )),
    );

    if (draggingMode == DraggingMode.Android) {
      content = DelayedReorderableListener(
        child: content,
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }
}