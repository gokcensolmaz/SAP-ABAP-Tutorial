*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE13
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample13.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

*&-----------Read Table with Index-----------*
  READ TABLE gt_scarr INTO gs_scarr INDEX 4.

  WRITE: gs_scarr.

*&-----------Read Table with Key-----------*
  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = 'AZ'.

  WRITE:/ gs_scarr.

*&-----------Read Table with Column Value-----------*
  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrname = 'Continental Airlines'.

  WRITE:/ gs_scarr.


*&-----------Read Table with Two Condition-----------*
  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrname = 'Continental Airlines'
                                             currcode = 'USD'.

  WRITE:/ gs_scarr.


*&-----------Read Table using Loop-----------*
  LOOP AT gt_scarr INTO gs_scarr WHERE currcode = 'EUR'.

    WRITE:/ gs_scarr.

  ENDLOOP.