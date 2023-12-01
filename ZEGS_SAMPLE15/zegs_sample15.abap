*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE15
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample15.

TYPES: BEGIN OF gty_equipment,
         equipment_id   TYPE int4,
         equipment_name TYPE char20,
         stock          TYPE int4,
       END OF gty_equipment.

TYPES: BEGIN OF gty_equipment2,
         equipment_id    TYPE int4,
         equipment_name  TYPE char20,
         stock           TYPE int4,
         equipment_color TYPE char10,
         equipment_size  TYPE char3,
       END OF gty_equipment2.

DATA: gt_equipment TYPE TABLE OF gty_equipment,
      gs_equipment TYPE gty_equipment.

DATA: gt_equipment2 TYPE TABLE OF gty_equipment2,
      gs_equipment2 TYPE gty_equipment2.

START-OF-SELECTION.

*  SELECT zegs_smp15_tab1~equipment_name
*         zegs_smp15_tab2~stock FROM zegs_smp15_tab1
*    INNER JOIN zegs_smp15_tab2 ON zegs_smp15_tab1~equipment_id EQ zegs_smp15_tab2~equipment_id
*    INTO CORRESPONDING FIELDS OF TABLE gt_equipment.

*&------Also written with AS keyword-----------------------------*
  SELECT tab1~equipment_id
         tab1~equipment_name
         tab2~stock
      FROM zegs_smp15_tab1 AS tab1
      INNER JOIN zegs_smp15_tab2 AS tab2 ON tab1~equipment_id EQ tab2~equipment_id
      INTO CORRESPONDING FIELDS OF TABLE gt_equipment.
  BREAK-POINT.

*&------Left Join-----------------------------*
  SELECT tab1~equipment_id
         tab1~equipment_name
         tab2~stock
    FROM zegs_smp15_tab1 AS tab1
    LEFT JOIN zegs_smp15_tab2 AS tab2 ON tab1~equipment_id EQ tab2~equipment_id
    INTO CORRESPONDING FIELDS OF TABLE gt_equipment.
  BREAK-POINT.

*&------Right Join----------------------------*
  SELECT *
    FROM zegs_smp15_tab1 AS tab1
    RIGHT JOIN zegs_smp15_tab2 AS tab2 ON tab1~equipment_id EQ tab2~equipment_id
    INTO CORRESPONDING FIELDS OF TABLE @gt_equipment.
  BREAK-POINT.

*&------Multiple Table Join----------------------------*
  SELECT tab1~equipment_id
         tab1~equipment_name
         tab2~stock
         tab3~equipment_color
         tab3~equipment_size
   FROM zegs_smp15_tab1 AS tab1
   INNER JOIN zegs_smp15_tab2 AS tab2 ON tab1~equipment_id EQ tab2~equipment_id
   INNER JOIN zegs_smp15_tab3 AS tab3 ON tab3~equipment_id EQ tab2~equipment_id
   INTO CORRESPONDING FIELDS OF TABLE gt_equipment2.
  BREAK-POINT.

*&------Multiple Table Left Join----------------------------*
  SELECT tab1~equipment_id
         tab1~equipment_name
         tab2~stock
         tab3~equipment_color
         tab3~equipment_size
   FROM zegs_smp15_tab1 AS tab1
   INNER JOIN zegs_smp15_tab2 AS tab2 ON tab1~equipment_id EQ tab2~equipment_id
   LEFT JOIN zegs_smp15_tab3 AS tab3 ON tab3~equipment_id EQ tab2~equipment_id
   INTO CORRESPONDING FIELDS OF TABLE gt_equipment2.
  BREAK-POINT.