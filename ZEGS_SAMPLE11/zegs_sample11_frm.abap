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
  INTO CORRESPONDING FIELDS OF TABLE gt_list.

  LOOP AT gt_list INTO gs_list.
    IF gs_list-ebelp EQ '10'.
      CLEAR: gs_cell_color.
      gs_cell_color-fieldname = 'TXZ01'.
      gs_cell_color-color-col = 3.
      gs_cell_color-color-int = 1.
      gs_cell_color-color-inv = 0.
      APPEND gs_cell_color TO gs_list-cell_color.

      CLEAR: gs_cell_color.
      gs_cell_color-fieldname = 'EBELP'.
      gs_cell_color-color-col = 3.
      gs_cell_color-color-int = 1.
      gs_cell_color-color-inv = 0.
      APPEND gs_cell_color TO gs_list-cell_color.
      MODIFY gt_list FROM gs_list.
    ENDIF.


*    -----LINE COLOR------
*    IF gs_list-ebelp EQ '10'.
*      gs_list-line_color = 'C600'.
*      MODIFY gt_list FROM gs_list.
*    ELSEIF gs_list-ebelp EQ '20'.
*      gs_list-line_color = 'C300'.
*      MODIFY gt_list FROM gs_list.
*    ELSEIF gs_list-ebelp EQ '30'.
*      gs_list-line_color = 'C500'.
*      MODIFY gt_list FROM gs_list.
*    ENDIF.

  ENDLOOP.

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

  PERFORM:set_fc_sub USING 'EBELN' 'SAS No' 'SAS Number' 'SAS Number' abap_true '0' abap_false 'X',
          set_fc_sub USING 'EBELP' 'Kalem' 'Kalem' 'Kalem' abap_true '1' abap_false '',
          set_fc_sub USING 'BSTYP' 'Belge Tipi' 'Belge Tipi' 'Belge Tipi' abap_false '2' abap_false '',
          set_fc_sub USING 'BSART' 'Belge Türü' 'Belge Türü' 'Belge Türü' abap_false '3' abap_false 'X',
          set_fc_sub USING 'TXZ01' 'Malzeme' 'Malzeme' 'Malzeme' abap_false '4' abap_false '',
          set_fc_sub USING 'MENGE' 'Miktar' 'Miktar' 'Miktar' abap_false '5' abap_true ''.

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
                      p_do_sum
                      p_hotspot.

  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = p_fieldname.
  gs_fieldcat-seltext_s = p_seltext_s.
  gs_fieldcat-seltext_m = p_seltext_m.
  gs_fieldcat-seltext_l = p_seltext_l.
  gs_fieldcat-key       = p_key.
  gs_fieldcat-col_pos   = p_col_pos.
  gs_fieldcat-do_sum    = p_do_sum.
  gs_fieldcat-hotspot = p_hotspot.

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
  gs_layout-box_fieldname = 'SELKZ'.
*  gs_layout-info_fieldname = 'LINE_COLOR'.
  gs_layout-coltab_fieldname = 'CELL_COLOR'.

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
  gs_event-name = slis_ev_top_of_page.
  gs_event-form = 'TOP_OF_PAGE'.
  APPEND gs_event TO gt_events.
  gs_event-name = slis_ev_end_of_list.
  gs_event-form = 'END_OF_LIST'.
  APPEND gs_event TO gt_events.

*  gs_event-name = slis_ev_pf_status_set.
*  gs_event-form = 'PF_STATUS_SET'.
*  APPEND gs_event TO gt_events.


  gs_exclude-fcode = '&ILT'.
  APPEND gs_exclude TO gt_exclude.

  gs_sort-tabname = 'GT_LIST'.
  gs_sort-spos = 1.
  gs_sort-fieldname = 'EBELN'.
  gs_sort-up = abap_true.
  APPEND gs_sort TO gt_sort.

  gs_sort-tabname = 'GT_LIST'.
  gs_sort-spos = 2.
  gs_sort-fieldname = 'EBELP'.
  gs_sort-down = abap_true.
  APPEND gs_sort TO gt_sort.

  gs_filter-tabname = 'GT_LIST'.
  gs_filter-fieldname = 'EBELP'.
  gs_filter-sign0 = 'I'.
  gs_filter-optio = 'LT'.
  gs_filter-valuf_int = '20'.
  APPEND gs_filter TO gt_filter.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK       = ' '
*     I_BYPASSING_BUFFER      = ' '
*     I_BUFFER_ACTIVE         = ' '
      i_callback_program      = sy-repid
*     i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command = 'USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE  = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME        =
*     I_BACKGROUND_ID         = ' '
*     I_GRID_TITLE            =
*     I_GRID_SETTINGS         =
      is_layout               = gs_layout
      it_fieldcat             = gt_fieldcat
      it_excluding            = gt_exclude
*     IT_SPECIAL_GROUPS       =
      it_sort                 = gt_sort
      it_filter               = gt_filter
*     IS_SEL_HIDE             =
*     I_DEFAULT               = 'X'
*     I_SAVE                  = ' '
*     IS_VARIANT              =
      it_events               = gt_events
*     IT_EVENT_EXIT           =
*     IS_PRINT                =
*     IS_REPREP_ID            =
*     I_SCREEN_START_COLUMN   = 0
*     I_SCREEN_START_LINE     = 0
*     I_SCREEN_END_COLUMN     = 0
*     I_SCREEN_END_LINE       = 0
*     I_HTML_HEIGHT_TOP       = 0
*     I_HTML_HEIGHT_END       = 0
*     IT_ALV_GRAPHICS         =
*     IT_HYPERLINK            =
*     IT_ADD_FIELDCAT         =
*     IT_EXCEPT_QINFO         =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab                = gt_list
* EXCEPTIONS
*     PROGRAM_ERROR           = 1
*     OTHERS                  = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM top_of_page .
  DATA: lt_header TYPE slis_t_listheader,
        ls_header TYPE slis_listheader.
  DATA: lv_date   TYPE char10.


  ls_header-typ = 'H'.
  ls_header-info = 'Satın alma sipariş rapor'.
  APPEND ls_header TO lt_header.

  ls_header-typ = 'S'.
  ls_header-key = 'Tarih'.
*  ls_header-info = '30/11/2023'.
*  sy-datum = '20231130'.
  CONCATENATE sy-datum+6(2)
              '.'
              sy-datum+4(2)
              '.'
              sy-datum+0(4)
              INTO lv_date.
  ls_header-info = lv_date.
  APPEND ls_header TO lt_header.



  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  END_OF_LIST
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM end_of_list .

  DATA: lt_header TYPE slis_t_listheader,
        ls_header TYPE slis_listheader.

  DATA: lv_lines   TYPE i,
        lv_lines_c TYPE char4.

  DESCRIBE TABLE gt_list LINES lv_lines.
  lv_lines_c = lv_lines.

  ls_header-typ = 'A'.
  CONCATENATE 'Raporda'
              lv_lines_c
              'adet girdi vardır.'
              INTO ls_header-info
              SEPARATED BY space.
  APPEND ls_header TO lt_header.



  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PF_STATUS_SET
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pf_status_set USING p_extab TYPE slis_t_extab.
  SET PF-STATUS '0100'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  USER_COMMAND
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM user_command USING p_ucomm     TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.
  DATA: lv_message TYPE char100,
        lv_index   TYPE numc2.

  CASE p_ucomm.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
    WHEN '&MSG'.
      LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
        lv_index = lv_index + 1.
      ENDLOOP.

      CONCATENATE lv_index
                  'adet satır seçilmiştir.'
                  INTO lv_message
                  SEPARATED BY space.
      MESSAGE lv_message TYPE 'I'.
    WHEN '&IC1'.
      CASE ps_selfield-fieldname.
        WHEN 'EBELN'.
          CONCATENATE ps_selfield-value
                      'numaralı SAS tıklanmıştır.'
                      INTO lv_message
                      SEPARATED BY space.
          MESSAGE lv_message TYPE 'I'.
        WHEN 'BSART'.
          CONCATENATE ps_selfield-value
                      'numaralı belge tıklanmıştır.'
                      INTO lv_message
                      SEPARATED BY space.
          MESSAGE lv_message TYPE 'I'.
        WHEN OTHERS.
      ENDCASE.
*      MESSAGE 'Çift tıklama yapıldı.' TYPE 'I'.
  ENDCASE.
ENDFORM.