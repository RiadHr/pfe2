import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../models/appointment.dart';
import '../../../providers/medecin_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../medecin/screens/medecin_detail_screen.dart';
import '../service/appointment_service.dart';
import 'booking_medecin_screen.dart';

class AppointmentMedecinScreen extends StatefulWidget {
  static const String routeName = '/rendez-vous-medecin';

  @override
  State<AppointmentMedecinScreen> createState() => _AppointmentMedecinScreenState();
}


//enum for appointment status
enum FilterStatus { prochain, complet, annuler }
class _AppointmentMedecinScreenState extends State<AppointmentMedecinScreen> {
  AppointmentService appointmentService = AppointmentService();
  AuthService authService = AuthService();

  FilterStatus status = FilterStatus.prochain; //initial status
  Alignment _alignment = Alignment.centerLeft;
  List<Appointment> schedules = [];
  List<Appointment> nextSchedules =[];
  List<Appointment> cancelSchedules =[];
  List<Appointment> completeSchedules =[];
  List<Appointment> currentSchedules = [];



  Color defaultColor = GlobalVariables.firstColor;

  fetchAllAppointment() async {
    schedules = await appointmentService.fetchAllAppointmentsByDoctor(context);
    filterAppointment();
    currentSchedules = nextSchedules;
    print(schedules);
    setState(() {});
  }

  void filterAppointment(){
    nextSchedules =[];
    cancelSchedules =[];
    completeSchedules =[];
    currentSchedules = [];
    for(int i=0;i<schedules.length;i++){
      if(schedules[i].status == 'prochain'){
        nextSchedules.add(schedules[i]);
      }else if(schedules[i].status == 'annuler'){
        cancelSchedules.add(schedules[i]);
      }else if(schedules[i].status == 'complet'){
        completeSchedules.add(schedules[i]);
      }
    }
    print(schedules.length);
    print(nextSchedules.length);
    print(completeSchedules.length);
    print(cancelSchedules.length);
  }


  @override
  void initState() {
    super.initState();
    fetchAllAppointment();
  }


  @override
  Widget build(BuildContext context) {
    // print(schedules);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.firstColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 55,
                child: Image(
                  image: AssetImage('images/tabibi.png'),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(defaultColor)),
                onPressed: () {
                  setState(() {
                    defaultColor =
                    defaultColor != GlobalVariables.secondaryColor
                        ? GlobalVariables.secondaryColor
                        : GlobalVariables.firstColor;
                    authService.logOut(context);
                  });
                },
                child: Text(
                  'Se déconnecter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Horaire de rendez-vous',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: GlobalVariables.firstColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //this is the filter tabs
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.prochain) {
                                  status = FilterStatus.prochain;
                                  _alignment = Alignment.centerLeft;
                                  currentSchedules = nextSchedules;
                                } else if (filterStatus ==
                                    FilterStatus.complet) {
                                  status = FilterStatus.complet;
                                  _alignment = Alignment.center;
                                  currentSchedules = completeSchedules;
                                } else if (filterStatus ==
                                    FilterStatus.annuler) {
                                  status = FilterStatus.annuler;
                                  _alignment = Alignment.centerRight;
                                  currentSchedules = cancelSchedules;
                                }
                              });
                            },
                            child: Center(
                              child: Text(filterStatus.name,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: GlobalVariables.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentSchedules.length,
                itemBuilder: ((context, index) {
                  Appointment schedule = currentSchedules[index];
                  bool isLastElement = currentSchedules.length + 1 == index;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule.doctorName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    schedule.userName,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ScheduleCard(
                            date: '${schedule.dateTime.day}/${schedule.dateTime.month.toString()}/${schedule.dateTime.year}',
                            day: schedule.dateTime.hour.toString(),
                            time: schedule.time,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                    GlobalVariables.secondaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      appointmentService.updateAppointmentStatus(context, schedule.id,'annuler');
                                      // schedule.status = 'annuler';
                                      filterAppointment();
                                      // print('${appointmentProvider.appointment.userName}');
                                    });
                                  },
                                  child: const Text(
                                    'annuler',
                                    style: TextStyle(
                                        color: GlobalVariables.fourthColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                    GlobalVariables.firstColor,
                                  ),
                                  onPressed: () {
                                    print('appointment =${schedule.id}');
                                    Navigator.pushNamed(
                                        context, BookingMedecinScreen.routeName,
                                        arguments:schedule );
                                  },
                                  child: const Text(
                                    'Reprogrammer',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key, required this.date, required this.day, required this.time})
      : super(key: key);
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalVariables.firstColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: GlobalVariables.fourthColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$date',
            style: const TextStyle(
              color: GlobalVariables.fourthColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: GlobalVariables.fourthColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
                time,
                style: const TextStyle(
                  color: GlobalVariables.fourthColor,
                ),
              ))
        ],
      ),
    );
  }
}
