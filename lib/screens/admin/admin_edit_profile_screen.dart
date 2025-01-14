import 'package:flutter/material.dart';
import '../../models/auth.dart';

class AuthEditProfileScreen extends StatefulWidget {
  final Auth auth;

  AuthEditProfileScreen({required this.auth});

  @override
  _AuthEditProfileScreenState createState() => _AuthEditProfileScreenState();
}

class _AuthEditProfileScreenState extends State<AuthEditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController departmentController;
  late TextEditingController joinDateController;
  late String selectedJobGroup;

  final List<String> jobGroups = [
    'F현장직군',
    'B관리직군',
    'G성장전략',
    'T기술직군',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.auth.name);
    idController = TextEditingController(text: widget.auth.id);
    departmentController = TextEditingController(text: widget.auth.department);
    joinDateController = TextEditingController(text: widget.auth.joinDate);
    selectedJobGroup = widget.auth.jobGroup;

    if (!jobGroups.contains(selectedJobGroup)) {
      selectedJobGroup = jobGroups.first;
    }
  }

  Future<void> _selectJoinDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.auth.joinDate.replaceAll('.', '-')) ??
          DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        joinDateController.text =
        "${pickedDate.year}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _saveChanges() {
    Navigator.pop(
      context,
      Auth(
        name: nameController.text,
        id: idController.text,
        department: departmentController.text,
        joinDate: joinDateController.text,
        jobGroup: selectedJobGroup,
        profileImage: widget.auth.profileImage,
        yearlyExperience: widget.auth.yearlyExperience, // 기존 경험치 유지
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '사원 정보 수정',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildEditableRow('이름', nameController),
              _buildEditableRow('사번', idController),
              _buildEditableRow('소속', departmentController),
              _buildEditableRowWithDatePicker('입사일', joinDateController, _selectJoinDate),
              _buildEditableDropdown('직무그룹', jobGroups, selectedJobGroup),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(widget.auth.profileImage),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 8),
          Text(
            nameController.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(
      String label,
      TextEditingController controller, {
        bool isNumber = false,
      }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.end,
                  keyboardType: isNumber ? TextInputType.number : TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }

  Widget _buildEditableRowWithDatePicker(
      String label,
      TextEditingController controller,
      Function onTap,
      ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.calendar_today, size: 18),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }

  Widget _buildEditableDropdown(
      String label,
      List<String> items,
      String selectedValue,
      ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              DropdownButton<String>(
                value: selectedValue,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedJobGroup = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
