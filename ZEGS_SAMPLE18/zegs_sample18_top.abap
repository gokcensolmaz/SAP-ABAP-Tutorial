*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE18_TOP
*&---------------------------------------------------------------------*

DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_fcat  TYPE lvc_t_fcat,
      gs_fcat  TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.