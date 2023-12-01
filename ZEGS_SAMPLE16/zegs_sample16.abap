*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE16
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample16.

DATA: gt_table1      TYPE TABLE OF zegs_smp15_tab1,
      gt_table2      TYPE TABLE OF zegs_smp15_tab2,
      gt_table2_temp TYPE TABLE OF zegs_smp15_tab2.

START-OF-SELECTION.

  SELECT * FROM zegs_smp15_tab1
    INTO TABLE gt_table1.

*  SELECT * FROM zegs_smp15_tab2
*    INTO TABLE gt_table2_temp.

  IF gt_table1 IS NOT INITIAL.
    SELECT * FROM zegs_smp15_tab2
      INTO TABLE gt_table2
      FOR ALL ENTRIES IN gt_table1
      WHERE equipment_id EQ gt_table1-equipment_id.
  ENDIF.

  BREAK-POINT.

*TYPES: BEGIN OF gty_equipment,
*         equipment_id   TYPE int4,
*         equipment_name TYPE char20,
*         stock          TYPE int4,
*       END OF gty_equipment.
*
*DATA: gt_equipment type table of gty_equipment.
*
*START-OF-SELECTION.
*
*SELECT * from ZEGS_SMP15_TAB1 as tab1
*  inner join ZEGS_SMP15_TAB2 as tab2 ON TAB1~equipment_id eq tab2~equipment_id
*  into CORRESPONDING FIELDS OF table gt_equipment.
*
*  BREAK-POINT.