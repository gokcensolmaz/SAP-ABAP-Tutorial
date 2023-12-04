*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE18_TOP
*&---------------------------------------------------------------------*

DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_scarr,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         message  TYPE char20,
       END OF gty_scarr.
DATA: gt_scarr TYPE TABLE OF gty_scarr,
      gt_fcat  TYPE lvc_t_fcat,
      gs_fcat  TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fc> type lvc_s_fcat.