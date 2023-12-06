*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE18_TOP
*&---------------------------------------------------------------------*
TYPE-POOLS icon.

DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_scarr,
         status   TYPE icon_d,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         cost     TYPE int4,
         location type char20,
*         message  TYPE char20,
*         line_color TYPE char4,
*         cell_color TYPE lvc_t_scol,
       END OF gty_scarr.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_scarr TYPE TABLE OF gty_scarr,
      gs_scarr TYPE gty_scarr,
      gt_fcat  TYPE lvc_t_fcat,
      gs_fcat  TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fc>    TYPE lvc_s_fcat,
               <gfs_scarr> TYPE gty_scarr.