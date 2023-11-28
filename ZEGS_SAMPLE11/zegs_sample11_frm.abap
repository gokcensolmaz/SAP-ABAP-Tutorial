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
  
    PERFORM:set_fc_sub USING 'EBELN' 'SAS No' 'SAS Number' 'SAS Number' abap_true '0' abap_false,
            set_fc_sub USING 'EBELP' 'Kalem' 'Kalem' 'Kalem' abap_true '1' abap_false,
            set_fc_sub USING 'BSTYP' 'Belge Tipi' 'Belge Tipi' 'Belge Tipi' abap_false '2' abap_false,
            set_fc_sub USING 'BSART' 'Belge Türü' 'Belge Türü' 'Belge Türü' abap_false '3' abap_false,
            set_fc_sub USING 'TXZ01' 'Malzeme' 'Malzeme' 'Malzeme' abap_false '4' abap_false,
            set_fc_sub USING 'MENGE' 'Miktar' 'Miktar' 'Miktar' abap_false '5' abap_true.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SET_FC_SUB
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_fc_sub USING p_fieldname
                        p_seltext_s
                        p_seltext_m
                        p_seltext_l
                        p_key
                        p_col_pos
                        p_do_sum.
  
    CLEAR: gs_fieldcat.
  
    gs_fieldcat-fieldname = p_fieldname.
    gs_fieldcat-seltext_s = p_seltext_s.
    gs_fieldcat-seltext_m = p_seltext_m.
    gs_fieldcat-seltext_l = p_seltext_l.
    gs_fieldcat-key       = p_key.
    gs_fieldcat-col_pos   = p_col_pos.
    gs_fieldcat-do_sum    = p_do_sum.
  
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