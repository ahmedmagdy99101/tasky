import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/theme/app_theme.dart';

class DatePickerField extends StatefulWidget {
  final DateTime dateTime;
  const DatePickerField({super.key, required this.dateTime});

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = DateFormat('d MMMM, yyyy').format(widget.dateTime);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('d MMMM, yyyy').format(widget.dateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'End Date',
                  style: TextStyle(color: const Color(0xFF6E6A7C),fontSize: 9.sp,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 4.h),
                Text(
                  _controller.text.isEmpty ? '30 June, 2022' : _controller.text,
                  style:  TextStyle(
                    fontSize: 14.sp,fontWeight: FontWeight.w400,
                    color: Colors.black,

                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_month_sharp,
              color: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDatePickerField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePickerField({super.key,
    required this.label,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  CustomDatePickerFieldState createState() => CustomDatePickerFieldState();
}

class CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFFBABABA))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   widget.label,
                //   style: const TextStyle(
                //     color: AppTheme.primaryColor,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
             //   const SizedBox(height: 8),
                Text(
                  DateFormat('d MMMM, yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
             Image.asset(
              "assets/icons/date.png",
              width: 24,
               height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
