*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE21_FRM
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
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
      <gfs_scarr>-delete = '@11@'.

    ENDLOOP.
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

  IF go_grid IS INITIAL.

    CREATE OBJECT go_cust
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_spli
      EXPORTING
        parent  = go_cust
        rows    = 2
        columns = 1.

    CALL METHOD go_spli->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_sub1.

    CALL METHOD go_spli->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_sub2.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_sub2.

    CALL METHOD go_spli->set_row_height
      EXPORTING
        id     = 1
        height = 15.

    CREATE OBJECT go_docu
      EXPORTING
        style = 'ALV_GRID'.

    PERFORM register_f4.

    CREATE OBJECT go_event_receiver.
    SET HANDLER go_event_receiver->handle_top_of_page FOR go_grid.
    SET HANDLER go_event_receiver->handle_hotspot_click FOR go_grid.
    SET HANDLER go_event_receiver->handle_double_click FOR go_grid.
    SET HANDLER go_event_receiver->handle_data_changed FOR go_grid.
    CALL METHOD go_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

    SET HANDLER go_event_receiver->handle_onf4 FOR go_grid.
    CALL METHOD go_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

    SET HANDLER go_event_receiver->handle_button_click for go_grid.

    SET HANDLER go_event_receiver->handle_toolbar for go_grid.
    SET HANDLER go_event_receiver->handle_user_command for go_grid.



    CALL METHOD go_grid->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.
    CALL METHOD go_grid->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = go_docu.
  ELSE.
    CALL METHOD go_grid->refresh_table_display.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      ct_fieldcat      = gt_fcat.
*&--------------hotspot_click----------------*
  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname EQ 'CARRID'.
      <gfs_fcat>-hotspot = abap_true.
    ENDIF.
  ENDLOOP.
*&--------------double_click----------------*
  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname EQ 'CARRNAME'.
      <gfs_fcat>-edit = abap_true.
    ENDIF.
  ENDLOOP.
*&--------------on_f4----------------*
  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname EQ 'CURRCODE'.
      <gfs_fcat>-edit = abap_true.
      <gfs_fcat>-f4availabl = abap_true.
*      <gfs_fcat>-style = cl_gui_alv_grid=>mc_style_f4.
    ENDIF.
  ENDLOOP.
*&--------------pushbutton_click----------------*
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'DELETE'.
  gs_fcat-scrtext_s = 'Delete'.
  gs_fcat-scrtext_m = 'Delete'.
  gs_fcat-scrtext_l = 'Delete'.
  gs_fcat-style = cl_gui_alv_grid=>mc_style_button.
  gs_fcat-icon = abap_true.
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
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-zebra = abap_true.
*  gs_layout-no_toolbar = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  REGISTER_F4
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM register_f4 .
  DATA: lt_f4 TYPE lvc_t_f4,
        ls_f4 TYPE lvc_s_f4.

  CLEAR ls_f4.
  ls_f4-fieldname = 'CURRCODE'.
  ls_f4-register = abap_true.
  APPEND ls_f4 TO lt_f4.

  CALL METHOD go_grid->register_f4_for_fields
    EXPORTING
      it_f4 = lt_f4.
ENDFORM.