*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE12
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample12.

DATA : gt_scarr TYPE TABLE OF scarr,
       gs_scarr TYPE scarr,
       gv_currcode type s_currcode.


START-OF-SELECTION.

*&------------Select-----------------------------*
  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrid EQ 'AC'.

  READ TABLE gt_scarr INTO gs_scarr INDEX 1.

  WRITE: gs_scarr-currcode.



*&------------Select Up To Rows-----------------------------*
  SELECT * UP TO 1 ROWS FROM scarr
    INTO TABLE gt_scarr
    WHERE carrid EQ 'AC'.

  READ TABLE gt_scarr INTO gs_scarr INDEX 1.

  WRITE: gs_scarr-currcode.


*&------------Select Single-----------------------------*
  SELECT SINGLE * FROM scarr
    INTO gs_scarr
    WHERE carrid EQ 'AC'.

  WRITE: gs_scarr-currcode.


*&------------Select Single-----------------------------*
  SELECT SINGLE currcode FROM scarr
    INTO gv_currcode
    WHERE carrid EQ 'AC'.

  WRITE: gv_currcode.