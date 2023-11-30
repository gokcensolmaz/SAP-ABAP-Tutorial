*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE04_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  CLEAR_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM clear_data .
    CLEAR: gv_name,
           gv_sname,
           gv_bdate,
           gv_department,
           gv_rad2,
           gv_checkbox.
    gv_rad1 = 'X'.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SAVE_DATA
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM save_data .
    CLEAR gs_personnel.
    gs_personnel-name = gv_name.
    gs_personnel-surname = gv_sname.
    gs_personnel-birth_date = gv_bdate.
    gs_personnel-department = gv_department.
    IF gv_rad1 = 'X'.
      gs_personnel-gender = 'M'.
    ENDIF.
    IF gv_rad2 = 'X'.
      gs_personnel-gender = 'F'.
    ENDIF.
    IF gv_checkbox = 'X'.
      gs_personnel-approve = 'X'.
    ENDIF.
    PERFORM calculate_age.
  
  
    IF gs_personnel-approve IS INITIAL.
      CLEAR: gs_cell_color.
      gs_cell_color-fieldname = 'APPROVE'.
      gs_cell_color-color-col = 7.
      gs_cell_color-color-int = 1.
      gs_cell_color-color-inv = 0.
      APPEND gs_cell_color TO gs_personnel-cell_color.
    ENDIF.
  
  
    APPEND gs_personnel TO gt_personnel.
    COMMIT WORK AND WAIT.
  
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  CALCULATE_AGE
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM calculate_age .
    CALL FUNCTION 'HRCM_TIME_PERIOD_CALCULATE'
      EXPORTING
        begda         = gv_bdate
        endda         = sy-datum
      IMPORTING
        noyrs         = gv_age
  *     nomns         = months
  *     nodys         = days
      EXCEPTIONS
        invalid_dates = 1
        overflow      = 2
        OTHERS        = 3.
  
    gs_personnel-age = gv_age.
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
  
    PERFORM: set_fc_sub  USING 'NAME'        'Name'        'Pers Name'        'Personnel Name'        '',
             set_fc_sub  USING 'SURNAME'     'Surname'     'Pers Surname'     'Personnel Surname'     '',
             set_fc_sub  USING 'BIRTH_DATE'  'B Date'      'Pers Birth Date'  'Personnel Birth Date'  '',
             set_fc_sub  USING 'GENDER'      'Gender'      'Pers Gender'      'Personnel Gender'      '',
             set_fc_sub  USING 'DEPARTMENT'  'Department'  'Pers Depatrment'  'Personnel Depatrment'  '',
             set_fc_sub  USING 'APPROVE'     'Approve'     'Pers Approve'     'Personnel Approve'     '',
             set_fc_sub  USING 'PERFORMANCE' 'Performance' 'Pers Performance' 'Personnel Performance' 'X'.
  
  
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
                        p_colname_s
                        p_colname_m
                        p_colname_l
                        p_edit.
  
    CLEAR gs_fieldcat.
    gs_fieldcat-fieldname = p_fieldname.
    gs_fieldcat-edit = p_edit.
    gs_fieldcat-seltext_s = p_colname_s.
    gs_fieldcat-seltext_m = p_colname_m.
    gs_fieldcat-seltext_l = p_colname_l.
  
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
    gs_layout-window_titlebar = 'Personnel Records'.
    gs_layout-zebra             = 'X'.
    gs_layout-colwidth_optimize = 'X'.
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
  *  gs_event-name = slis_ev_pf_status_set.
  *  gs_event-form = 'PF_STATUS_SET'.
  *  APPEND gs_event TO gt_events.
  
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
  *     I_INTERFACE_CHECK       = ' '
  *     I_BYPASSING_BUFFER      = ' '
  *     I_BUFFER_ACTIVE         = ' '
        i_callback_program      = sy-repid
  *     i_callback_pf_status_set = ' PF_STATUS_SET'
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
  *     IT_EXCLUDING            =
  *     IT_SPECIAL_GROUPS       =
  *     IT_SORT                 =
  *     IT_FILTER               =
  *     IS_SEL_HIDE             =
  *     I_DEFAULT               = 'X'
        i_save                  = 'X'
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
  *     IT_EXCEPT_QINFO         = gt_cell_color
  *     IR_SALV_FULLSCREEN_ADAPTER        =
  * IMPORTING
  *     E_EXIT_CAUSED_BY_CALLER =
  *     ES_EXIT_CAUSED_BY_USER  =
      TABLES
        t_outtab                = gt_personnel
  * EXCEPTIONS
  *     PROGRAM_ERROR           = 1
  *     OTHERS                  = 2
      .
    IF sy-subrc <> 0.
  * Implement suitable error handling here
    ENDIF.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  USER_COMAND
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM user_command USING p_ucomm TYPE sy-ucomm
                         ps_selfield TYPE slis_selfield .
  
    DATA: lv_message TYPE char100.
  
    CASE p_ucomm.
      WHEN '&IC1'.
        gv_tabix = ps_selfield-tabindex.
        READ TABLE gt_personnel INDEX gv_tabix INTO gs_personnel.
        CASE ps_selfield-fieldname.
          WHEN 'PERFORMANCE'.
            gs_personnel-performance = ps_selfield-value.
            IF gs_personnel-performance < 30.
              CLEAR gs_cell_color.
              gs_cell_color-fieldname = 'PERFORMANCE'.
              gs_cell_color-color-col = '6'.
              gs_cell_color-color-int = '1'.
              gs_cell_color-color-inv = '0'.
              APPEND gs_cell_color TO gs_personnel-cell_color.
              MODIFY gt_personnel FROM gs_personnel INDEX gv_tabix.
            ELSEIF gs_personnel-performance < 50.
              CLEAR gs_cell_color.
              gs_cell_color-fieldname = 'PERFORMANCE'.
              gs_cell_color-color-col = '6'.
              gs_cell_color-color-int = '0'.
              gs_cell_color-color-inv = '0'.
              APPEND gs_cell_color TO gs_personnel-cell_color.
              MODIFY gt_personnel FROM gs_personnel INDEX gv_tabix.
            ELSEIF gs_personnel-performance < 80.
              CLEAR gs_cell_color.
              gs_cell_color-fieldname = 'PERFORMANCE'.
              gs_cell_color-color-col = '3'.
              gs_cell_color-color-int = '1'.
              gs_cell_color-color-inv = '0'.
              APPEND gs_cell_color TO gs_personnel-cell_color.
              MODIFY gt_personnel FROM gs_personnel INDEX gv_tabix.
            ELSEIF gs_personnel-performance < 100.
              CLEAR gs_cell_color.
              gs_cell_color-fieldname = 'PERFORMANCE'.
              gs_cell_color-color-col = '5'.
              gs_cell_color-color-int = '1'.
              gs_cell_color-color-inv = '0'.
              APPEND gs_cell_color TO gs_personnel-cell_color.
              MODIFY gt_personnel FROM gs_personnel INDEX gv_tabix.
            ENDIF.
        ENDCASE.
        PERFORM display_alv.
    ENDCASE.
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
    SET PF-STATUS 'ALV'.
  ENDFORM.