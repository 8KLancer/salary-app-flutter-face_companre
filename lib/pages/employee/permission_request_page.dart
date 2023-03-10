import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salaryredesign/constants/colors.dart';
import 'package:salaryredesign/constants/image_urls.dart';
import 'package:salaryredesign/constants/sized_box.dart';
import 'package:salaryredesign/functions/navigation_functions.dart';
import 'package:salaryredesign/pages/payroll/add_pay_per_work.dart';
import 'package:salaryredesign/providers/clock.dart';
import 'package:salaryredesign/services/api_urls.dart';
import 'package:salaryredesign/services/webservices.dart';
import 'package:salaryredesign/widgets/CustomLoader.dart';
import 'package:salaryredesign/widgets/CustomTexts.dart';
import 'package:salaryredesign/widgets/appbar.dart';
import 'package:salaryredesign/widgets/buttons.dart';
import 'package:salaryredesign/widgets/custom_widgets.dart';
import 'package:salaryredesign/widgets/dropdown.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salaryredesign/widgets/showSnackbar.dart';

import '../../constants/constans.dart';
import '../../widgets/customtextfield.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

class MyPermission_Request_Page extends StatefulWidget {
  const MyPermission_Request_Page({Key? key}) : super(key: key);

  @override
  State<MyPermission_Request_Page> createState() =>
      _MyPermission_Request_PageState();
}

final dataMap = <String, double>{
  "leave": 20,
};
final dataMap1 = <String, double>{
  "leave": 20,
};
final dataMap2 = <String, double>{
  "leave": 20,
};

final colorList = <Color>[
  MyColors.primaryColor,
];
final colorList1 = <Color>[
  MyColors.secondarycolor,
];
final colorList2 = <Color>[
  Color(0xFFDC2626),
];

class _MyPermission_Request_PageState extends State<MyPermission_Request_Page> {
  TextEditingController search = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? shiftStart;
  String? shiftEnd;
  Map userData={};
  Map approvedBy={};
  List history=[];
  getHistory()async{
    Provider.of<GlobalModal>(context, listen: false).load=true;
    var res = await Webservices.getData(ApiUrls.permissionhistoryview);
    Provider.of<GlobalModal>(context, listen: false).loadingHide();
    log("res------permissionhistoryview-------$res");
    var jsonResponse = convert.jsonDecode(res.body);
    log('res from new api ---------permissionhistoryview---$jsonResponse');
    userData=jsonResponse['userData'];
    // approvedBy=jsonResponse['approved_by'];
    history=jsonResponse['data'];


  }
  @override
  void initState() {
    // TODO: implement initState
    getHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffold,
      appBar: appBar(
          context: context, title: 'Permission Request', titlecenter: false),
      body: Consumer<GlobalModal>(builder: (context, globalModal, child) {
        return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 110,
                      color: MyColors.disabledcolor,
                      child: DefaultTabController(
                        initialIndex: 0,
                        length: 2,
                        child: Scaffold(
                          backgroundColor: MyColors.disabledcolor,
                          body: Column(
                            children: [
                              Container(
                                color: MyColors.white,
                                child: TabBar(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  indicatorColor: MyColors.yellow,
                                  indicatorWeight: 3,
                                  tabs: <Widget>[
                                    Tab(
                                      child: Text(
                                        'NEW REQUEST',
                                        style: TextStyle(
                                            color: MyColors.black,
                                            fontSize: 16,
                                            fontFamily: 'bold'),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'HISTORY',
                                        style: TextStyle(
                                            color: MyColors.black,
                                            fontSize: 16,
                                            fontFamily: 'bold'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              vSizedBox05,
                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: MyColors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            )),
                                        height:
                                            MediaQuery.of(context).size.height -
                                                125,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            vSizedBox2,
                                            GestureDetector(
                                              onTap: () async {
                                                DateTime? temp =
                                                    await showDatePicker(

                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                        DateTime.now(),
                                                        lastDate:
                                                            DateTime(2099));
                                                // showTimePicker(context: context, initialTime: initialTime)
                                                if (temp != null) {
                                                  dateTime = temp;
                                                  date.text =
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(dateTime!)
                                                          .toString();
                                                }
                                                setState(() {});
                                              },
                                              child: CustomTextField(
                                                controller: date,
                                                hintText: '',
                                                label: 'Choose Date',
                                                showlabel: true,
                                                enable: false,
                                              ),
                                            ),
                                            vSizedBox2,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      TimeOfDay? temp =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                        builder: (BuildContext
                                                                context,
                                                            Widget? child) {
                                                          return MediaQuery(
                                                            data: MediaQuery.of(
                                                                    context)
                                                                .copyWith(
                                                                    alwaysUse24HourFormat:
                                                                    false),
                                                            child: child!,
                                                          );
                                                        },
                                                      );
                                                      if (temp != null) {
                                                        startTime = temp;
                                                        print('${startTime}');

                                                        start.text = startTime
                                                            .toString()
                                                            .substring(10, 15);
                                                        shiftStart = start.text;
                                                        start.text =
                                                        '${DateFormat.jm().format(DateTime.parse('2000-01-01 ' + start.text))}';
                                                            // '${DateFormat('hh:mm:s').format(DateTime.parse('2000-01-01 ' + start.text))}';
                                                      }

                                                      // setState(() {});
                                                    },
                                                    child: CustomTextField(
                                                      controller: start,
                                                      hintText: '',
                                                      label: 'Start Time',
                                                      showlabel: true,
                                                      labelcolor:
                                                          MyColors.black,
                                                      enable: false,
                                                    ),
                                                  ),
                                                ),
                                                hSizedBox,
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      TimeOfDay? temp =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                        startTime!,
                                                        builder: (BuildContext
                                                                context,
                                                            Widget? child) {
                                                          return MediaQuery(
                                                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                            child: child!,
                                                          );
                                                        },
                                                      );
                                                      if (temp != null) {
                                                        endTime = temp;
                                                        print('${endTime}');
                                                        end.text = endTime
                                                            .toString()
                                                            .substring(10, 15);
                                                        shiftEnd = end.text;

                                                        end.text =
                                                        '${DateFormat.jm().format(DateTime.parse('2000-01-01 ' + end.text))}';

                                                      }

                                                      // setState(() {});
                                                    },
                                                    child: CustomTextField(
                                                      controller: end,
                                                      hintText: '',
                                                      label: 'End time',
                                                      showlabel: true,
                                                      labelcolor:
                                                          MyColors.black,
                                                      enable: false,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            vSizedBox2,
                                            CustomTextField(
                                              controller: reason,
                                              hintText: '',
                                              label: 'Reason',
                                              showlabel: true,
                                              labelcolor: MyColors.black,
                                              maxLines: 5,
                                            ),
                                            vSizedBox4,
                                            RoundEdgedButton(

                                              text: 'REQUEST PERMISSION',
                                              onTap: () async {
                                                print('time -------------${startTime} , ${endTime}');
                                                if (date.text == '') {
                                                  showSnackbar(context,
                                                      'Please choose date.');
                                                } else if (start.text == '') {
                                                  showSnackbar(context,
                                                      'Please choose start time.');
                                                } else if (end.text == '') {
                                                  showSnackbar(context,
                                                      'Please choose end time.');
                                                } else if (reason.text == '') {
                                                  showSnackbar(context,
                                                      'Please enter reason.');
                                                }
                                             else if(DateTime.parse('${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse('2000-01-01 ' + startTime.toString().substring(10,15)))}').compareTo(DateTime.parse('${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse('2000-01-01 ' + endTime.toString().substring(10,15)))}')) > 0){
                                                  showSnackbar(context,
                                                      'Please enter valid time.');
                                                }
                                                else {
                                                  Map<String, dynamic> data = {
                                                    'date': date.text,
                                                    'start_time': startTime.toString().substring(10,15),
                                                    'end_time':endTime.toString().substring(10,15),
                                                    'reason': reason.text
                                                  };
                                                  print('object-------$data');
                                                  globalModal.loadingShow();
                                                  var res = await Webservices
                                                      .postData(
                                                          apiUrl: ApiUrls.permissionRequestStore,
                                                          body: data,
                                                          context: context);
                                                  globalModal.loadingHide();
                                                  showSnackbar(
                                                      context, res['message']);
                                                  getHistory();
                                                  log("res---------$res");
                                                  if(res['success'].toString()=='true'){
                                                    date.text='';
                                                    start.text='';
                                                    end.text='';
                                                    reason.text='';
                                                  }



                                                  DefaultTabController.of(context)?.animateTo(2);

                                                }
                                              },
                                            ),
                                            vSizedBox4,
                                          ],
                                        ),
                                      ),
                                    ),
                                    globalModal.load
                                        ? CustomLoader()
                                        : SingleChildScrollView(
                                      child: Container(
                                        color: MyColors.disabledcolor,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Column(
                                          children: [
                                            for (var i = 0; i < history.length; i++)
                                              GestureDetector(
                                                child: Permission_Request_list(
                                                  text: '${userData['name']}',
                                                  subtext: '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(history[i]['created_at']))}',
                                                  img: '${userData['avatar']}',
                                                  btns: false,
                                                  chipcolor: history[i]['status'].toString()=='1'?MyColors.secondarycolor:history[i]['status'].toString()=='2'?MyColors.red:MyColors.yellow,

                                                  chiptextcolor: MyColors.white,
                                                  chiptext: history[i]['status'].toString()=='1'?'Approved':history[i]['status'].toString()=='2'?'Rejected':'Pending',
                                                  location: false,
                                                  privilaged_leave: true, date: '${history[i]['date']}',
                                                  start: '${DateFormat.jm().format(DateTime.parse('2022-11-19 ${history[i]['start_time']}.000Z'))}',
                                                  end: '${DateFormat.jm().format(DateTime.parse('2022-11-19 ${history[i]['end_time']}.000Z'))}', total: history[i]['total_minute'],
                                                ),
                                                onTap: () {
                                                  bottomsheet(
                                                      radius: 0,
                                                      height: 480,
                                                      context: context,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          vSizedBox2,
                                                          MainHeadingText(
                                                            text:
                                                                'View Permission Approval',
                                                            fontSize: 20,
                                                          ),
                                                          vSizedBox,
                                                          Permission_Request_list(
                                                            permission_hours:false,
                                                            description: '${history[i]['reason']}',
                                                            chiptext: history[i]['status'].toString()=='1'?'Approved':history[i]['status'].toString()=='2'?'Rejected':'Pending',
                                                            text:
                                                                '${userData['name']}',
                                                            subtext:
                                                                '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(history[i]['created_at']))}',
                                                            img: '${userData['avatar']}',
                                                            chipcolor: history[i]['status'].toString()=='1'?MyColors.secondarycolor:history[i]['status'].toString()=='2'?MyColors.red:MyColors
                                                                .yellow,
                                                            chiptextcolor:
                                                                MyColors.white,
                                                            horizontalpad: 0,
                                                            btns: false,
                                                            privilaged_leave: true,
                                                            date: '${history[i]['date']}',
                                                            start: '${DateFormat('hh:mm a').format(DateTime.parse('2022-11-19 ${history[i]['start_time']}.000Z'))}',
                                                            end: '${DateFormat('hh:mm a').format(DateTime.parse('2022-11-19 ${history[i]['end_time']}.000Z'))}',
                                                            total: history[i]['total_minute'],

                                                            // permission_hours:
                                                            //     true,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if(history[i]['approve_by']!=null)
                                                              MainHeadingText(
                                                                text:
                                                                    '${history[i]['approve_by']??''}',
                                                                fontSize: 15,
                                                              ),
                                                              vSizedBox05,
                                                              ParagraphText(
                                                                text:
                                                                history[i]['status'].toString()=='1'?'Approved By':history[i]['status'].toString()=='2'?'Rejected By':'',
                                                                color: MyColors
                                                                    .labelcolor,
                                                                fontSize: 14,
                                                              )
                                                            ],
                                                          ),
                                                          vSizedBox2,
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if(history[i]['decline_reason']!=null)

                                                                MainHeadingText(
                                                                text:
                                                                    'Reject Reason',
                                                                fontSize: 15,
                                                              ),
                                                              vSizedBox05,
                                                              if(history[i]['decline_reason']!=null)
                                                              ParagraphText(
                                                                text:
                                                                    '${history[i]['decline_reason']}',
                                                                color: MyColors
                                                                    .labelcolor,
                                                                fontSize: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ));
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
