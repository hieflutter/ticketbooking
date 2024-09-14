import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/customappnavi.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/responsive/responsive.dart';

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  Map<String, dynamic>? _changepasswordData;

  @override
  void initState() {
    super.initState();
   
    }
  

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final preferredSize = Responsive.isTablet(context)
        ? ScreenSizeConfig.ScreenWidth * 0.08
        : ScreenSizeConfig.ScreenWidth * 0.15;

    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
        
          child:customappbarnavi(
            customappbarnavitittle: 'change password',
          )
          
           
          
          ),
      body: SingleChildScrollView(
       child: 
           Container(
            margin: EdgeInsets.only(top: 50 , left: 12 ,right: 12),
            width: ScreenSizeConfig.ScreenWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
           color: ScreenSizeConfig.customwhite,),
           child: Padding(
             padding: const EdgeInsets.all(9.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 customcardcolumn("Current Password"),
           customcardcolumn("New Password"),
            customcardcolumn("confirm Password"),
            
             
                
               ],
             ),
           ),
           
           ),
        
       
     ) );
  }
// }

  
Widget customcardcolumn (
 String customtext ,

  
){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(customtext,style: subtittletextgrey,overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 8,),
       Text("Enter",style: subtittletext,overflow: TextOverflow.ellipsis,),
       SizedBox(height: 8,),
       Divider()
       ]
    );
}

}