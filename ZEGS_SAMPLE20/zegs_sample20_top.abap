*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE20_TOP
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
         result      TYPE char2,
         cell_color  TYPE lvc_t_scol,
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
      gt_personnel TYPE TABLE OF gty_list.

DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fcat>      TYPE lvc_s_fcat,
               <gfs_personnel> TYPE gty_list.

CLASS cl_gridhandler DEFINITION DEFERRED.
DATA: go_event_receiver TYPE REF TO cl_gridhandler.


DATA: go_docu TYPE REF TO cl_dd_document.