*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE17
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample17.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr.

FIELD-SYMBOLS: <gfs_scarr> TYPE scarr.

START-OF-SELECTION.
*&-----------Traditional Way--------------*

*  SELECT * FROM scarr
*    INTO TABLE gt_scarr.
*
*
*  LOOP AT  gt_scarr INTO gs_scarr.
*    IF gs_scarr-carrid EQ 'LH'.
*      gs_scarr-carrname = 'Lithuania Airlines'.
*      MODIFY gt_scarr FROM gs_scarr.
*    ENDIF.
*  ENDLOOP.
*
*  BREAK-POINT.

*&-----------New Way----------------------*

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    IF <gfs_scarr>-carrid EQ 'LH'.
      <gfs_scarr>-carrname = 'Lithuania Airlines'.
    ENDIF.
  ENDLOOP.

  BREAK-POINT.

*&-----------With Read Table----------------*
*
*  SELECT * FROM scarr
*    INTO TABLE gt_scarr.
*
*  READ TABLE gt_scarr ASSIGNING <gfs_scarr> WITH KEY carrid = 'LH'.
*  <gfs_scarr>-carrname = 'Lithuania Airlines'.
*  BREAK-POINT.