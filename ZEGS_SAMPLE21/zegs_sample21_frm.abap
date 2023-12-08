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

    CREATE OBJECT go_event_receiver.
    SET HANDLER go_event_receiver->handle_top_of_page FOR go_grid.
    SET HANDLER go_event_receiver->handle_hotspot_click FOR go_grid.
    SET HANDLER go_event_receiver->handle_double_click FOR go_grid.
    SET HANDLER go_event_receiver->handle_data_changed FOR go_grid.
    call METHOD go_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.


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

  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname eq 'CARRID'.
      <gfs_fcat>-hotspot = abap_true.
    ENDIF.
  ENDLOOP.
  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname eq 'CARRNAME'.
      <gfs_fcat>-edit = abap_true.
    ENDIF.
  ENDLOOP.
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
ENDFORM.