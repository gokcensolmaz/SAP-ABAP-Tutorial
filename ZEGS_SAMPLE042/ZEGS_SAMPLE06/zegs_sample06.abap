*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE06
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample06.




INCLUDE zegs_sample06_cls.

DATA go_math_op TYPE REF TO math_op.
DATA go_math_op_diff TYPE REF TO math_op_diff.

START-OF-SELECTION.
*&-----------------------Local Class-----------------------------------*
  CREATE OBJECT go_math_op.


  go_math_op->lv_num1 = 20.
  go_math_op->lv_num2 = 12.
  go_math_op->addition( ).

  WRITE / go_math_op->lv_result.


*&-----------------------Alt Class-----------------------------------*
  CREATE OBJECT go_math_op_diff.

  go_math_op_diff->lv_num1 = 10.
  go_math_op_diff->lv_num2 = 12.
  go_math_op_diff->subtraction( ).
  
  WRITE / go_math_op_diff->lv_result.

*&--------------------MESSAGE TYPE & MESSAGE CLASS => SE91 ----------*

* MESSAGE 'Hello ABAP World' type 'S' DISPLAY LIKE 'E'.
* MESSAGE 'Hello ABAP World' type 'I' DISPLAY LIKE 'S'.
* MESSAGE 'Hello ABAP World' type 'W'.
* MESSAGE 'Hello ABAP World' type 'E'.
* MESSAGE 'Hello ABAP World' type 'A'.
* MESSAGE 'Hello ABAP World' type 'X'.

MESSAGE text-000 TYPE 'I'.
  