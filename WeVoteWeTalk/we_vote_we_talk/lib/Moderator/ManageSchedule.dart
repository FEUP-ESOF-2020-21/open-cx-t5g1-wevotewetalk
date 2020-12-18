import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import '../Database.dart';
import '../Shared/Idea.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';

// ignore: non_constant_identifier_names
var first_time = true;


class ManageSchedule extends StatefulWidget {

  final user_id;
  final talk_id;


  ManageSchedule({this.user_id, this.talk_id});

  @override
  _ManageScheduleState createState() => _ManageScheduleState(user_id: this.user_id, talk_id: this.talk_id);
}

class ItemData {
  ItemData(this.idea, this.key);

  final Idea idea;
  final Key key;
}

enum DraggingMode {
  iOS,
  Android,
}

class _ManageScheduleState extends State<ManageSchedule> {
  List<ItemData> _items = List<ItemData>();
  final user_id;
  final talk_id;

  bool _exit = false;

  _ManageScheduleState({this.user_id, this.talk_id});/* {
    String label = "Cães";
    _items.add(ItemData(label, ValueKey(0)));
    label = "Gatos";
    _items.add(ItemData(label, ValueKey(1)));
  }*/

  /*Widget getList() {
    return StreamBuilder<List<Idea>>(
        stream: DatabaseService(user_id, talk_id).ideas,
        // ignore: missing_return
        builder: (context, snapshot) {
          List<Idea> ideas = snapshot.data;
          print("Ideas = " + ideas.toString());
        });
  }*/

  fillIdeas(List<Idea> ideas)
  {
    ideas.sort((a, b) => b.votes.compareTo(a.votes));
    if(first_time)
    {
      var i = 0;
      for(var idea in ideas)
      {
        if (i == 15)
          break;
        _items.add(ItemData(idea, ValueKey(i)));
        i++;
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: StreamBuilder<ConferenceData>(
          stream: DatabaseService(user_id, talk_id).conferenceData,
          builder: (context, snapshot) {
            if(snapshot.hasData)
            {
              ConferenceData conferenceData = snapshot.data;
              if(!_exit)
                DatabaseService(user_id, talk_id).updateConference(ConferenceData(conferenceData.name, false, false, false, conferenceData.banned));
              return StreamBuilder<List<Idea>>(
                  stream: DatabaseService(user_id, talk_id).ideas,
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      List<Idea> ideas = snapshot.data;
                      fillIdeas(ideas);
                      first_time = false;
                      return Scaffold(
                        body: Column(
                          children: [
                            Expanded(
                              child: ReorderableList(
                                onReorder: this._reorderCallback,
                                onReorderDone: this._reorderDone,
                                child: CustomScrollView(
                                  // cacheExtent: 3000,
                                  slivers: <Widget>[
                                    SliverAppBar(
                                      leading: Builder(
                                          builder: (BuildContext context) {
                                            return IconButton(
                                              icon: Icon(Icons.arrow_back),
                                              onPressed: () => navigateBackToModeratorOptions(),
                                            );
                                          }),

                                      title: Text('We Vote We Talk'),
                                      //automaticallyImplyLeading: false,
                                      backgroundColor: Color(0xFF106799),
                                      pinned: true,
                                    ),
                                    SliverPadding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).padding.bottom),
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
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 20.0,
                                ),
                                child:MaterialButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  child: Text('Finish and Open Sessions'),
                                  onPressed: () async {
                                    for(var i = 0; i < _items.length; i++)
                                    {
                                      print(_items[i].idea.name);
                                      await DatabaseService(user_id, talk_id).updateIdeas(_items[i].idea.name, _items[i].idea.votes, _items[i].idea.documentID, i);
                                    }
                                    _exit = true;
                                    await DatabaseService(user_id, talk_id).updateConference(ConferenceData(conferenceData.name, false, false, true, conferenceData.banned));
                                    navigateBackToModeratorOptions();
                                  },
                                  minWidth: 200.0,
                                  height: 45.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                )
                            ),
                            SizedBox(height: 10.0,)
                          ],
                        ),
                      );
                    }
                    else
                      return Loading();
                  }
              );
            }
            else
              return Loading();
          }
      ),
      onWillPop: () async {
        return navigateBackToModeratorOptions();
      }
    );
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
    debugPrint("Reordering finished for ${draggedItem.idea.name}}");
  }

  DraggingMode _draggingMode = DraggingMode.iOS;

  navigateBackToModeratorOptions() {
  first_time = true;
  Navigator.pop(context);
}

}

// ==============================================================================================================================

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
                          child: Text(data.idea.name + " (" + data.idea.votes.toString() + " votes)",
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
