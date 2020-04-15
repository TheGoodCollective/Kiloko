import 'package:flutter/material.dart';
import 'package:kiloko/config/app_utils.dart';



class SymptomWidget extends StatelessWidget {
  final Function onSelectSymptom;
  final String symptom;
  final bool isSelected;

  SymptomWidget({
    this.onSelectSymptom, this.symptom, this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        width: screenSize.width,
        child: Row(
          children: <Widget>[
            
            isSelected 
              ? 
              Icon(
                Icons.check,
                color: AppColors.black,
                size: 28,
              ) 
             : Container(), 
            isSelected ? SizedBox(width: 16,): SizedBox(width: 0,),
            Text(
              symptom,
              style: isSelected 
                      ? 
                      Theme.of(context).textTheme.body2.copyWith(
                        fontWeight: FontWeight.w600
                      ) : Theme.of(context).textTheme.body2,
            ),

          ],
        ),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),

          border: Border.all(
            color: AppColors.tertiaryAlt,
          ),
          
          color: isSelected ? AppColors.tertiaryAlt.withOpacity(0.5) : AppColors.white,
          boxShadow: <BoxShadow> [
            
            BoxShadow(
              color: AppColors.tertiaryAlt,
              blurRadius: 4,
              spreadRadius: 4,
            ),

          ]
        ),
        duration: Duration(seconds: 1),
      ),

      onTap: () {
        this.onSelectSymptom(
          symptom: symptom, isSelected: isSelected, context: context
        );
      },
    );
  }
}