import 'package:flutter/material.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/register.dart';
import 'package:kult/ui/android/router/router.gr.dart';
import 'package:kult/ui/contrats/screen.dart';
import 'package:kult/ui/contrats/screen_routing.dart';

class ListKnown extends Screen {
  const ListKnown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: _Child());
  }
}

class _Child extends StatefulWidget {
  _Child({Key key}) : super(key: key);

  @override
  _ChildState createState() => _ChildState();
}

const LIMIT = 25;

class _ChildState extends State<_Child> with ScreenRouting {
  Member _filter = Member();
  String _lastUid;
  final _all = <Member>[],
      _datas = <Member>[],
      editingController = TextEditingController(),
      _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    // filter.choice = ChoiceList.SAMEDI2;
    _search(_filter);
    _scroll.addListener(() {
      if (_scroll.position.pixels == _scroll.position.minScrollExtent) {
        bool check1 = false;
        for (var i = 1; i < _datas.length; i++) {
          final el1 = _datas[i - 1];
          final el2 = _datas[i];
          if (orderList(el1, el2) == 1) {
            check1 = true;
            break;
          }
        }

        if (check1) {
          setState(() {
            _datas.sort(orderList);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const search = "Recherche";
    return Scaffold(
      body: SafeArea(
        // minimum: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (fullName) {
                  _filterFunction(fullName: fullName);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: search,
                    hintText: search,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                      ),
                      onPressed: () {
                        editingController.clear();
                        _filterFunction();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _scroll,
                  itemBuilder: _itemBuilder,
                  // separatorBuilder: null,
                  itemCount: _datas.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushNamed(Routes.register),
        child: Icon(Icons.person_add),
      ),
    );
  }

  _fetchMore(
    Member filter, {
    int limit = LIMIT,
  }) async {
    final getDatas = (await registerContainer.readMore(
      filter,
      limit: limit,
      uid: _lastUid,
    ));
    setState(() {
      _lastUid = getDatas.last;
      _all.addAll(
        getDatas.datas.where(
          (el) => isNullStringEvery([el.firstNames, el.lastName]),
        ),
      );
      _datas.addAll(getDatas.datas);
    });
  }

  Future<Null> _fetchAll(Member filter) async {
    final getDatas = (await registerContainer.readMany(
      filter,
    ))
        .where(
      (el) => !isNullStringEvery([el.firstNames, el.lastName]),
    ).toList();
    setState(() {
      _all.addAll(
        getDatas
          ..sort(
            orderList,
          ),
      );
      _datas.addAll(_all);
    });
  }

  int orderList(Member el1, Member el2) {
    final lastName1 = forceStringRender(el1.lastName);
    final firstNames1 = forceStringRender(el1.firstNames);
    final lastName2 = forceStringRender(el2.lastName);
    final firstNames2 = forceStringRender(el1.firstNames);

    final compare = ((lastName1 + firstNames1).replaceAll(' ', ''))
        .compareTo((lastName2 + firstNames2).replaceAll(' ', ''));
    // print('Compairing...');
    return compare;
  }

  _filterFunction({String fullName, bool respectCase = false}) {
    final _fullName = fullName == null
        ? null
        : respectCase ? fullName.toLowerCase() : fullName;
    if (isNullString(_fullName)) {
      setState(() {
        _datas.addAll(_all.where((element) => !_datas.contains(element)));
      });
    } else {
      final getter = _all.where((el) {
        return !isNullStringAny([el.lastName, el.firstNames]) &&
            (respectCase
                    ? (el.lastName + el.firstNames)
                    : (el.lastName + el.firstNames).toLowerCase())
                .contains(_fullName.trim());
      });
      setState(() {
        _datas.clear();
        if (getter.isNotEmpty) _datas.addAll(getter);
      });
    }
  }

  _search(
    Member filter, {
    int limit = LIMIT,
    bool all = true,
  }) {
    final response = all ? _fetchAll(filter) : _fetchMore(filter, limit: limit);
    return response;
  }

  Widget _itemBuilder(BuildContext ctx, int index) {
    final _data = _datas.elementAt(index);
    final _choice = _data?.choice;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(Icons.person_pin),
      ),
      title: Text(
          '${_datas[index].lastName ?? ""} ${_datas[index].firstNames ?? ""}'),
      subtitle: Text(_choice.text ?? 'Non attribué'),
      onTap: () => pushNamed(Routes.setMember,
          arguments: SetMemberArguments(data: _data)),
    );
  }

  _resetFilter() => _filter = Member()..choice = ChoiceList.SAMEDI1;

  _resetDatas() => _datas.clear();
}
