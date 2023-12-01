*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE11_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF gty_list,
         selkz      TYPE char1,
         ebeln      TYPE ebeln,
         ebelp      TYPE ebelp,
         bstyp      TYPE ebstyp,
         bsart      TYPE ebsart,
         txz01      TYPE txz01,
         menge      TYPE bstmg,
         line_color TYPE char4,
         cell_color TYPE slis_t_specialcol_alv,
       END OF gty_list.

DATA: gt_list TYPE TABLE OF gty_list,
      gs_list TYPE gty_list.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

DATA: gs_layout TYPE slis_layout_alv.

DATA: gt_events TYPE slis_t_event,
      gs_event  TYPE slis_alv_event.

DATA: gs_cell_color TYPE slis_specialcol_alv.

DATA: gt_exclude TYPE slis_t_extab,
      gs_exclude TYPE slis_extab.

DATA: gt_sort TYPE slis_t_sortinfo_alv,
      gs_sort TYPE slis_sortinfo_alv.

DATA: gt_filter TYPE slis_t_filter_alv,
      gs_filter TYPE slis_filter_alv.