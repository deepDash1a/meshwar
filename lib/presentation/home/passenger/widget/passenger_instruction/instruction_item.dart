import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

class InstructionsDetails extends StatelessWidget {
  const InstructionsDetails({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.white,
            size: 20.00,
          ),
        ),
        titleSpacing: 0.00,
        title: CustomText(
          text: title,
          fontSize: 16.00.sp,
          fontFamily: FontManager.bold,
          color: ColorsManager.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.00.w, vertical: 16.00.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.00.w,
                    vertical: 20.00.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getInstructionsDetails(title),
                          maxLines: 200,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 2.2,
                            fontSize: 14.00.sp,
                            fontFamily: FontManager.bold,
                            color: ColorsManager.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getInstructionsDetails(String text) {
    switch (text) {
      case 'السيارة':
        return '- المحافظة على نظافة السيارة.\n\n - تعامل مع السيارة كأنها سيارتك.';
      case 'السائق':
        return '- اربط حزام الأمان دائمًا: لضمان سلامتك وسلامة الآخرين، تأكد من ربط حزام الأمان في جميع الأوقات أثناء القيادة. \n\n - التأكد من ضغط الإطارات: قبل كل رحلة، افحص ضغط الإطارات لضمان قيادة آمنة وسلسة. \n\n - استخدام إشارات الانعطاف: تأكد دائمًا من تشغيل إشارات الانعطاف قبل تغيير الاتجاهات أو المسار. \n\n - احترام قوانين المرور: اتبع الإشارات والقواعد المرورية بانتظام لضمان سلامتك وسلامة الآخرين. \n\n - حافظ على مسافة أمان: اترك مسافة آمنة بينك وبين السيارة التي أمامك لتجنب الحوادث المفاجئة. \n\n - استخدام المرآة الجانبية والوسطى: تحقق دائمًا من المرايا قبل تغيير المسار أو الانعطاف. \n\n - هذه التعليمات يمكن استخدامها كإرشادات عامة لتعزيز السلامة والكفاءة';
      case 'الركاب':
        return '- عدم المحادثة مع الركاب إلا في الضرورة، وغير ذلك يتم الالتزام بالطريق فقط.\n\n- عدم السماح للركاب بالتدخين.';
      case 'معلومات عامة':
        return '- البدأ والانتهاء في الموعد المخصص للشيفت وفي حالة التأخير يتم التنسيق مع الادارة/الكابتن الاخر. \n\n - استلام وتسليم السيارة في المكان المتفق عليه مع الادارة وفي حالة التغيير يتم التنسيق مع الادارة/الكابتن الاخر. \n\n - ممنوع التحدث في الهاتف المحمول اثناء السير. \n\n - الالتزام بحزام الامان. \n\n - ممنوع التدخين في السيارة.';
    }
    return '';
  }
}
