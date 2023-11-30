*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE03_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF gty_list,
         name        TYPE char30,
         surname     TYPE char30,
         birth_date  TYPE datum,
         age         TYPE num2,
         department  TYPE char20,
         gender      TYPE char1,
         approve     TYPE xfeld,
         performance TYPE int4,
         cell_color type slis_t_specialcol_alv,
       END OF gty_list.

DATA: gv_name       TYPE char30,
      gv_sname      TYPE char30,
      gv_bdate      TYPE datum,
      gv_age        TYPE num2,
      gv_department TYPE char20.

DATA: gv_rad1 TYPE char1,
      gv_rad2 TYPE char1.

DATA: gv_checkbox   TYPE xfeld.

DATA: gs_personnel TYPE gty_list,
      gt_personnel type TABLE OF gty_list.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

DATA: gs_layout TYPE slis_layout_alv.

DATA: gs_cell_color type slis_specialcol_alv,
      gt_cell_color TYPE TABLE OF slis_specialcol_alv.

DATA: gt_events TYPE slis_t_event,
      gs_event  TYPE slis_alv_event.

DATA: gv_tabix TYPE sy-tabix.