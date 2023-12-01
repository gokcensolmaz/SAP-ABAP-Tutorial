*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE14
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample14.

DATA: gt_scarr TYPE TABLE OF scarr.

TYPES: BEGIN OF gty_scarr,
*         mandt    TYPE s_mandt,
*         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
*         url      TYPE s_carrurl,
       END OF gty_scarr.

DATA: gt_scarrtype TYPE TABLE OF gty_scarr.

START-OF-SELECTION.

*&----------No error------------------*
  SELECT * FROM scarr
    INTO TABLE gt_scarr.


*&---------With error------------------*
  SELECT carrid carrname FROM scarr
    INTO TABLE gt_scarr.


*&---------Corresponding------------------*
  SELECT carrid carrname FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr.


*&---------With error------------------*
SELECT * from scarr
  into table gt_scarrtype.


*&---------Corresponding------------------*
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarrtype.
  BREAK-POINT.

