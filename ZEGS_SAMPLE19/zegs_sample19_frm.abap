*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE19_FRM
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
    gs_personnel-name       = gv_name.
    gs_personnel-surname    = gv_sname.
    gs_personnel-birth_date = gv_bdate.
    gs_personnel-department = gv_department.
    IF gv_rad1            = 'X'.
      gs_personnel-gender = 'M'.
    ENDIF.
    IF gv_rad2            = 'X'.
      gs_personnel-gender = 'F'.
    ENDIF.
    IF gv_checkbox         = 'X'.
      gs_personnel-approve = 'X'.
    ENDIF.
    PERFORM calculate_age.
  
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
        begda = gv_bdate
        endda = sy-datum
      IMPORTING
        noyrs = gv_age.
    gs_personnel-age = gv_age.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SET_FCAT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_fcat .
    PERFORM: set_fcat_sub USING 'NAME'        'Name'        'Pers Name'     'Personnel Name'        abap_false,
             set_fcat_sub USING 'SURNAME'     'Surname'     'Pers Surname'  'Personnel Surname'     abap_false,
             set_fcat_sub USING 'BIRTH_DATE'  'Birth Date'  'Pers BDate'    'Personnel Birth Date'  abap_false,
             set_fcat_sub USING 'AGE'         'Age'         'Pers Age'      'Personnel Age'         abap_false,
             set_fcat_sub USING 'GENDER'      'Gender'      'Pers Gender'   'Personnel Gender'      abap_false,
             set_fcat_sub USING 'DEPARTMENT'  'Department'  'Pers Dep.'     'Personnel Department'  abap_false,
             set_fcat_sub USING 'APPROVE'     'Approve'     'Pers Appr.'    'Personnel Approve'     abap_false,
             set_fcat_sub USING 'PERFORMANCE' 'Performance' 'Pers Perf.'    'Personnel Performance' abap_true,
             set_fcat_sub USING 'RESULT'      'Result'      'Pers Res'      'Personnel Result'      abap_false.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  SET_FCAT_SUB
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_fcat_sub USING p_fieldname
                          p_colname_s
                          p_colname_m
                          p_colname_l
                          p_edit.
    CLEAR gs_fcat.
    gs_fcat-fieldname = p_fieldname.
    gs_fcat-scrtext_s = p_colname_s.
    gs_fcat-scrtext_m = p_colname_m.
    gs_fcat-scrtext_l = p_colname_l.
    gs_fcat-edit      = p_edit.
  
    APPEND gs_fcat TO gt_fcat.
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *&      Form  SET_LAYOUT
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM set_layout.
    CLEAR gs_layout.
    gs_layout-zebra      = abap_true.
    gs_layout-col_opt    = abap_true.
    gs_layout-ctab_fname = 'CELL_COLOR'.
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  DISPLAY_ALV
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM display_alv.
  
    IF go_alv IS INITIAL.
      CREATE OBJECT go_container
        EXPORTING
          container_name = 'CC_ALV'.
  
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_container.
  
      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
          is_layout       = gs_layout
        CHANGING
          it_outtab       = gt_personnel
          it_fieldcatalog = gt_fcat.
  
  
      CALL METHOD go_alv->register_edit_event
        EXPORTING
          i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  
    ELSE.
      CALL METHOD go_alv->refresh_table_display.
  
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  CALCULATE_STATUS
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *  -->  p1        text
  *  <--  p2        text
  *----------------------------------------------------------------------*
  FORM calculate_status.
  
    LOOP AT gt_personnel ASSIGNING <gfs_personnel>.
      IF <gfs_personnel>-performance < 25.
        <gfs_personnel>-result  = 'FF'.
        PERFORM color_cell USING '6' '1' '0'.
      ELSEIF <gfs_personnel>-performance < 50.
        <gfs_personnel>-result  = 'DD'.
        PERFORM color_cell USING '7' '1' '0'.
      ELSEIF <gfs_personnel>-performance < 75.
        <gfs_personnel>-result  = 'CC'.
        PERFORM color_cell USING '3' '1' '0'.
      ELSEIF <gfs_personnel>-performance < 100.
        <gfs_personnel>-result  = 'BB'.
        PERFORM color_cell USING '3' '0' '0'.
      ELSE.
        <gfs_personnel>-result  = 'AA'.
        PERFORM color_cell USING '5' '1' '0'.
      ENDIF.
    ENDLOOP.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *&      Form  COLOR_CELL
  *&---------------------------------------------------------------------*
  *       text
  *----------------------------------------------------------------------*
  *
  *
  *
  *----------------------------------------------------------------------*
  FORM color_cell  USING    p_col
                            p_int
                            p_inv.
  
    CLEAR: gs_cell_color,
           <gfs_personnel>-cell_color .
  
    gs_cell_color-fname     = 'RESULT'.
    gs_cell_color-color-col = p_col.
    gs_cell_color-color-int = p_int.
    gs_cell_color-color-inv = p_inv.
  
    APPEND gs_cell_color TO <gfs_personnel>-cell_color.
  
  ENDFORM.