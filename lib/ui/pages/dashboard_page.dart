import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/bloc/schedule_bloc.dart';
import 'package:mydesign/bloc/schedule_state.dart';
import 'package:mydesign/data/models/schedule_model.dart';
import 'package:mydesign/utils/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            "Jadwal Saya",
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: softShadow,
                ),
                labelColor: AppColors.accent,
                unselectedLabelColor: AppColors.textGrey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [Tab(text: "Hari Ini"), Tab(text: "Minggu Ini")],
              ),
            ),
          ),
        ),
        body: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              );
            } else if (state is ScheduleLoaded) {
              return TabBarView(
                children: [
                  _buildList(state.todaySchedules),
                  _buildList(state.weeklySchedules),
                ],
              );
            } else {
              return const Center(child: Text("Belum ada jadwal"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<Schedule> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text("Kosong", style: TextStyle(color: AppColors.textGrey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: softShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.note,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                "${item.date.hour}:${item.date.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
