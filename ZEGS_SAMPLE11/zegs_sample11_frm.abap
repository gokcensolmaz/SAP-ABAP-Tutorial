*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE11_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
    SELECT
     ekko~ebeln
     ekpo~ebelp
     ekko~bstyp
     ekko~bsart
     ekpo~txz01
     ekpo~menge
     FROM ekko
     INNER JOIN ekpo ON ekpo~ebeln EQ ekko~ebeln
     INTO TABLE gt_list.
 
 ENDFORM.
 *&---------------------------------------------------------------------*
 *&      Form  SET_FIELDCAT
 *&---------------------------------------------------------------------*
 *       text
 *----------------------------------------------------------------------*
 *  -->  p1        text
 *  <--  p2        text
 *----------------------------------------------------------------------*
 FORM set_fieldcat .
 
 *&----------------FIELD CATALOG---------------
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'EBELN'.
   gs_fieldcat-seltext_s = 'SAS No'.
   gs_fieldcat-seltext_m = 'SAS Number'.
   gs_fieldcat-seltext_l = 'SAS Number'.
   gs_fieldcat-key       =  abap_true.
 * gs_fieldcat-outputlen = 20.
 *  gs_fieldcat-edit      = 'X'.
   gs_fieldcat-hotspot   = 'X'.
   APPEND gs_fieldcat TO gt_fieldcat.
 
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'EBELP'.
   gs_fieldcat-seltext_s = 'Kalem'.
   gs_fieldcat-seltext_m = 'Kalem'.
   gs_fieldcat-seltext_l = 'Kalem'.
   gs_fieldcat-key       =  abap_true.
   APPEND gs_fieldcat TO gt_fieldcat.
 
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'BSTYP'.
   gs_fieldcat-seltext_s = 'Belge Tipi'.
   gs_fieldcat-seltext_m = 'Belge Tipi'.
   gs_fieldcat-seltext_l = 'Belge Tipi'.
   gs_fieldcat-col_pos = 2.
 *  gs_fieldcat-edit      = 'X'.
   APPEND gs_fieldcat TO gt_fieldcat.
 
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'BSART'.
   gs_fieldcat-seltext_s = 'Belge Türü'.
   gs_fieldcat-seltext_m = 'Belge Türü'.
   gs_fieldcat-seltext_l = 'Belge Türü'.
   gs_fieldcat-col_pos = 3.
   APPEND gs_fieldcat TO gt_fieldcat.
 
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'TXZ01'.
   gs_fieldcat-seltext_s = 'Malzeme'.
   gs_fieldcat-seltext_m = 'Malzeme'.
   gs_fieldcat-seltext_l = 'Malzeme'.
   gs_fieldcat-col_pos = 4.
   APPEND gs_fieldcat TO gt_fieldcat.
 
   CLEAR: gs_fieldcat.
   gs_fieldcat-fieldname = 'MENGE'.
   gs_fieldcat-seltext_s = 'Miktar'.
   gs_fieldcat-seltext_m = 'Miktar'.
   gs_fieldcat-seltext_l = 'Miktar'.
   gs_fieldcat-col_pos = 5.
   gs_fieldcat-do_sum = abap_true.
   APPEND gs_fieldcat TO gt_fieldcat.
 
 ENDFORM.
 *&---------------------------------------------------------------------*
 *&      Form  SET_LAYOUT
 *&---------------------------------------------------------------------*
 *       text
 *----------------------------------------------------------------------*
 *  -->  p1        text
 *  <--  p2        text
 *----------------------------------------------------------------------*
 FORM set_layout .
 
 *&-----------------LAYOUT-----------------
   gs_layout-window_titlebar = 'REUSE ALV Example'.
   gs_layout-zebra             = 'X'.
   gs_layout-colwidth_optimize = 'X'.
 
 ENDFORM.
 *&---------------------------------------------------------------------*
 *&      Form  DISPLAY_ALV
 *&---------------------------------------------------------------------*
 *       text
 *----------------------------------------------------------------------*
 *  -->  p1        text
 *  <--  p2        text
 *----------------------------------------------------------------------*
 FORM display_alv .
 
 
   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
     EXPORTING
 *     I_INTERFACE_CHECK                 = ' '
 *     I_BYPASSING_BUFFER                = ' '
 *     I_BUFFER_ACTIVE                   = ' '
 *     I_CALLBACK_PROGRAM                = ' '
 *     I_CALLBACK_PF_STATUS_SET          = ' '
 *     I_CALLBACK_USER_COMMAND           = ' '
 *     I_CALLBACK_TOP_OF_PAGE            = ' '
 *     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
 *     I_CALLBACK_HTML_END_OF_LIST       = ' '
 *     I_STRUCTURE_NAME                  =
 *     I_BACKGROUND_ID                   = ' '
 *     I_GRID_TITLE                      =
 *     I_GRID_SETTINGS                   =
       is_layout   = gs_layout
       it_fieldcat = gt_fieldcat
 *     IT_EXCLUDING                      =
 *     IT_SPECIAL_GROUPS                 =
 *     IT_SORT     =
 *     IT_FILTER   =
 *     IS_SEL_HIDE =
 *     I_DEFAULT   = 'X'
 *     I_SAVE      = ' '
 *     IS_VARIANT  =
 *     IT_EVENTS   =
 *     IT_EVENT_EXIT                     =
 *     IS_PRINT    =
 *     IS_REPREP_ID                      =
 *     I_SCREEN_START_COLUMN             = 0
 *     I_SCREEN_START_LINE               = 0
 *     I_SCREEN_END_COLUMN               = 0
 *     I_SCREEN_END_LINE                 = 0
 *     I_HTML_HEIGHT_TOP                 = 0
 *     I_HTML_HEIGHT_END                 = 0
 *     IT_ALV_GRAPHICS                   =
 *     IT_HYPERLINK                      =
 *     IT_ADD_FIELDCAT                   =
 *     IT_EXCEPT_QINFO                   =
 *     IR_SALV_FULLSCREEN_ADAPTER        =
 * IMPORTING
 *     E_EXIT_CAUSED_BY_CALLER           =
 *     ES_EXIT_CAUSED_BY_USER            =
     TABLES
       t_outtab    = gt_list
 * EXCEPTIONS
 *     PROGRAM_ERROR                     = 1
 *     OTHERS      = 2
     .
   IF sy-subrc <> 0.
 * Implement suitable error handling here
   ENDIF.
 
 ENDFORM.