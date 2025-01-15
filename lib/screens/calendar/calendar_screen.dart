import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/search_textField.dart';
import '../../widgets/productivity_progress_bar.dart';
import '../../widgets/home_container.dart';

class CalendarScreen extends StatefulWidget {
  final Map<DateTime, List<Map<String, dynamic>>> events;
  final ValueChanged<Map<DateTime, List<Map<String, dynamic>>>> onEventsChanged;

  const CalendarScreen({
    Key? key,
    required this.events,
    required this.onEventsChanged,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarScreen> {
  final DateTime _firstDay = DateTime.utc(2024, 10, 1);
  final DateTime _lastDay = DateTime.utc(2025, 12, 31);

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredTasks = [];
  Timer? _debounce;

  double _currentProgress = 8.013; // 현재 게이지 값
  double _goal1 = 4.3; // 첫 번째 목표값
  double _goal2 = 5.1; // 두 번째 목표값
  int _totalPoints = 1280; // 포인트 값

  final Map<DateTime, double> _productivity = {
    DateTime(2025, 1, 14): 4.4,
    DateTime(2025, 1, 16): 5.4,
    DateTime(2025, 1, 29): 4.5,
    DateTime(2024, 11, 29): 5.5,
    DateTime(2025, 4, 14): 2.7,
    DateTime(2025, 4, 17): 2.3,
    DateTime(2025, 1, 1): 5.9,
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _filteredTasks = _getAllTasks();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> _getAllTasks() {
    return widget.events.entries
        .expand((entry) => entry.value.map((task) => {...task, 'date': entry.key}))
        .toList()
      ..sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
  }

  void _filterTasks(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        setState(() {
          _filteredTasks = [];
        });
        return;
      }

      setState(() {
        _filteredTasks = _getAllTasks()
            .where((task) => task['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      });

      if (_filteredTasks.isNotEmpty) {
        _openSearchResultsDialog(_filteredTasks);
      }
    });
  }

  void _openSearchResultsDialog(List<Map<String, dynamic>> tasks) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '검색 결과',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(
                    '${task['date'].year}년 ${task['date'].month}월 ${task['date'].day}일',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedDay = task['date'];
                      _focusedDay = task['date'];
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '닫기',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openEventDialog(DateTime day) {
    final tasks = widget.events[day] ?? [];
    final TextEditingController _taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.white,
              title: Text(
                '${day.year}년 ${day.month}월 ${day.day}일',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _taskController,
                      cursorColor: const Color(0xFF2E9629),
                      decoration: const InputDecoration(
                        hintText: '새로운 일정 추가',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2E9629)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '진행 중인 일정',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ...tasks.map(
                          (task) => Row(
                        children: [
                          Checkbox(
                            value: task['done'],
                            activeColor: const Color(0xFF2E9629),
                            onChanged: (value) {
                              setState(() {
                                task['done'] = value ?? false;
                                widget.onEventsChanged(widget.events);
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              task['title'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                tasks.remove(task);
                                widget.onEventsChanged(widget.events);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    String newTask = _taskController.text.trim();
                    if (newTask.isNotEmpty) {
                      setState(() {
                        if (widget.events[day] == null) {
                          widget.events[day] = [];
                        }
                        widget.events[day]!.add({'title': newTask, 'done': false});
                        widget.onEventsChanged(widget.events);
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('저장', style: TextStyle(color: Color(0xFF2E9629))),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('닫기', style: TextStyle(color: Colors.grey)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;

      final double? selectedProd = _productivity[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)];

      if (selectedProd != null) {
        _currentProgress = selectedProd;
      }
    });
    _openEventDialog(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '달력'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchTextField(
              hintText: '일정을 검색하세요',
              onChanged: _filterTasks,
              controller: _searchController,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 430,
                    child: TableCalendar(
                      locale: 'ko_KR',
                      firstDay: _firstDay,
                      lastDay: _lastDay,
                      focusedDay: _focusedDay,
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      daysOfWeekHeight: 40, // 요일 간격 조정
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, day, focusedDay) {
                          final double? prod = _productivity[DateTime(day.year, day.month, day.day)];
                          Color bgColor = Colors.transparent;
                          if (prod != null) {
                            if (prod < 4.3) {
                              bgColor = Colors.transparent;
                            } else if (prod < 5.1) {
                              bgColor = Colors.lightGreen.withOpacity(0.3);
                            } else {
                              bgColor = Colors.green.withOpacity(0.3);
                            }
                          }
                          return Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.brown,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        todayBuilder: (context, day, focusedDay) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        defaultBuilder: (context, day, focusedDay) {
                          final double? prod = _productivity[DateTime(day.year, day.month, day.day)];
                          Widget dayText = Center(
                            child: Text('${day.day}',
                                style: const TextStyle(color: Colors.black)),
                          );

                          if (prod == null) {
                            return dayText;
                          } else if (prod < 4.3) {
                            return dayText;
                          } else if (prod < 5.1) {
                            return Container(
                              color: Colors.lightGreen.withOpacity(0.3),
                              child: dayText,
                            );
                          } else {
                            return Container(
                              color: Colors.green.withOpacity(0.3),
                              child: dayText,
                            );
                          }
                        },
                        markerBuilder: (context, day, events) {
                          if (widget.events[day] != null &&
                              widget.events[day]!.isNotEmpty) {
                            return Positioned(
                              bottom: 1,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2E9629),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 2),
                          ),
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                        ),
                        selectedDecoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.brown, width: 2),
                          ),
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                        ),
                        defaultTextStyle: TextStyle(color: Colors.black),
                        todayTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        markerDecoration: BoxDecoration(
                          color: Color(0xFF2E9629),
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomProgressBar(
                      title: '${_focusedDay.month}월 ${_selectedDay?.day ?? _focusedDay.day}일',
                      currentValue: _currentProgress,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomContainer(
                      title: '${_focusedDay.month}월에 얻은 총 do',
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            '800',
                            style: TextStyle(
                              fontFamily: 'Dohyeon',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
