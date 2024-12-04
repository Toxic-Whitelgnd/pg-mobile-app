import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/services/MongoDB.dart';
import 'package:pgapp/services/dataService/clientHistoryService.dart';

class ClientHistoryScreen extends StatefulWidget {
  const ClientHistoryScreen({super.key});

  @override
  State<ClientHistoryScreen> createState() => _ClientHistoryScreenState();
}

class _ClientHistoryScreenState extends State<ClientHistoryScreen> {

  final ClientHistoryService _clientHistoryService = locator<ClientHistoryService>();

  String _selectedCriteria = 'name';
  String _searchQuery = '';
  DateTime? _startDate;
  DateTime? _endDate;

  List<Map<String, dynamic>>? clientHistory;
  List<Map<String, dynamic>>? _filteredData;

  void _filterData(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });

    if (clientHistory != null) {
      _filteredData = clientHistory!.where((element) {
        final item = element[_selectedCriteria].toString().toLowerCase();
        return item.contains(_searchQuery);
      }).toList();
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? datePicked = await showDateRangePicker(
        context: context, firstDate: DateTime(2023), lastDate: DateTime(2025));
    if (datePicked != null) {
      setState(() {
        _startDate = datePicked.start;
        _endDate = datePicked.end;
      });
      _filterByDate();

      print(_startDate);
    }

  }

  void _filterByDate() {
    setState(() {
      if (_startDate != null && _endDate != null) {
        _filteredData = clientHistory!.where((item) {
          DateTime? date;
          if (item['doj'] != null) {
            date = DateFormat('dd/MM/yyyy').parse(item['doj']);
          } else if (item['dol'] != null) {
            date = DateTime.parse(item['dol']);
          }

          if (date != null) {
            return date.isAfter(_startDate!) && date.isBefore(_endDate!);
          }
          return false;
        }).toList();
      }
    });
  }

  void _sortData() {
    setState(() {
      if (_selectedCriteria == 'date') {
        _filteredData!.sort((a, b) {
          DateTime? dateA, dateB;

          if (a['doj'] != null) {
            dateA = DateFormat('dd/MM/yyyy').parse(a['doj']);
          } else if (a['dol'] != null) {
            dateA = DateTime.parse(a['dol']);
          }

          if (b['doj'] != null) {
            dateB = DateFormat('dd/MM/yyyy').parse(b['doj']);
          } else if (b['dol'] != null) {
            dateB = DateTime.parse(b['dol']);
          }

          if (dateA != null && dateB != null) {
            return dateA.compareTo(dateB);
          }
          return 0; // Fallback if one or both dates are null
        });
      } else {
        _filteredData!.sort((a, b) => a[_selectedCriteria]
            .toString()
            .compareTo(b[_selectedCriteria].toString()));
      }
    });
  }

  Future<void> _sendToServer() async {
    var res = await _clientHistoryService.getClientHistory();
    if (res.isNotEmpty) {
      setState(() {
        clientHistory = res;
        _filteredData = clientHistory;
      });
      print("after data is fetched");
    }
  }

  @override
  void initState() {
    super.initState();
    _sendToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client History"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text("Enter..."),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterData,
                  ),
                ),
                DropdownButton(
                    value: _selectedCriteria,
                    items: const [
                      DropdownMenuItem(
                        child: Text("Name"),
                        value: 'name',
                      ),
                      DropdownMenuItem(
                        child: Text("MobileNumber"),
                        value: 'mobileno',
                      ),
                      DropdownMenuItem(
                        child: Text("Date"),
                        value: 'date',
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedCriteria = val;
                        });
                      }
                      if (val == 'date') {
                        _selectDateRange(context);
                      } else {
                        _sortData();
                      }
                    })
              ],
            ),
            if (_selectedCriteria == 'date')
              Text(
                  "Search Resulf for ${_startDate != null || _startDate == '' ? _startDate.toString().substring(0, 10) : ''} - ${_endDate != null || _endDate == '' ? _endDate.toString().substring(0, 10): ''}")
            else
              _searchQuery == ''
                  ? Text("")
                  : Text("Search result $_searchQuery"),
            clientHistory == null
                ? CircularProgressIndicator()
                : _filteredData!.isEmpty
                    ? const Text(
                        "No result Found",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: _filteredData!.length,
                            itemBuilder: (context, index) {
                              final item = _filteredData![index];

                              return Card(
                                child: ListTile(
                                  title: Text(item['name']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Floor:   " + item['floor']),
                                      Text("RoomNo:   " + item['room']),
                                      Text("Date of Join:   " + item['doj']),
                                      Text("Sharing:   " + item['sharing']),
                                      Text("MobileNo:   " + item['mobileno']),
                                      Text("Date of Leaving:   ${item['dol']
                                              .toString()
                                              .substring(0, 10)}"),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
          ],
        ),
      ),
    );
  }
}
