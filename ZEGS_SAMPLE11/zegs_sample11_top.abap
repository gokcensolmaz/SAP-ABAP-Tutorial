*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE11_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF gty_list,
         ebeln TYPE ebeln,
         ebelp TYPE ebelp,
         bstyp TYPE ebstyp,
         bsart TYPE ebsart,
         txz01 TYPE txz01,
         menge TYPE bstmg,
       END OF gty_list.

DATA: gt_list TYPE TABLE OF gty_list,
      gs_list TYPE gty_list.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

DATA: gs_layout TYPE slis_layout_alv.