import 'package:flutter/material.dart';
import 'package:travel_app/Data/model/event_model.dart';
import 'package:travel_app/services/event_service.dart';


class CityEventScreen extends StatefulWidget {
  final String thanhPhoId;
  final String thanhPhoName;

  const CityEventScreen({
    Key? key,
    required this.thanhPhoId,
    required this.thanhPhoName,
  }) : super(key: key);

  @override
  State<CityEventScreen> createState() => _CityEventScreenState();
}

class _CityEventScreenState extends State<CityEventScreen> {
  late Future<List<EventModel>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = EventService.getEventsByCity(widget.thanhPhoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sự kiện tại ${widget.thanhPhoName}')),
      body: FutureBuilder<List<EventModel>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Đã có lỗi: ${snapshot.error}'));
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text('Không có sự kiện nào!'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.tenSuKien,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bắt đầu: ${_formatDate(event.ngayBatDau)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Kết thúc: ${_formatDate(event.ngayKetThuc)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.noiDung,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
