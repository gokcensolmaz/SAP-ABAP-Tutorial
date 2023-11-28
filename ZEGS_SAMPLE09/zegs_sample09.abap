*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE09
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample09.

DATA: gt_sbook TYPE TABLE OF sbook,
      go_salv  TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT * UP TO 20 ROWS FROM sbook
  INTO TABLE gt_sbook.
  cl_salv_table=>factory(

    IMPORTING
      r_salv_table   = go_salv    " Basis Class Simple ALV Tables
    CHANGING
      t_table        = gt_sbook
  ).
*  CATCH cx_salv_msg.    "

  DATA: lo_display TYPE REF TO cl_salv_display_settings.
  lo_display = go_salv->get_display_settings( ).
  lo_display->set_list_header( value = 'SALV Example' ). "Set title of SALV

  lo_display->set_striped_pattern( value = 'X' ). "Zebra pattern in lines

  DATA: lo_cols TYPE REF TO cl_salv_columns. "optimize columns' width
  lo_cols = go_salv->get_columns( ).
  lo_cols->set_optimize( value = 'X' ).

  DATA:lo_col TYPE REF TO cl_salv_column.

  TRY .
      lo_col = lo_cols->get_column( columnname = 'INVOICE1' ). "Set column name according to length
      lo_col->set_long_text( value = 'Yeni Fatura Düzenleyici' ).
      lo_col->set_medium_text( value = 'Yeni Fatura D.' ).
      lo_col->set_short_text( value = 'Yeni F. D.' ).
    CATCH cx_salv_not_found.

  ENDTRY.


  lo_col = lo_cols->get_column( columnname = 'MANDT' ). "Change visibility of one column
  lo_col->set_visible( value = if_salv_c_bool_sap=>false ).

  DATA: lo_func TYPE REF TO cl_salv_functions.
  lo_func = go_salv->get_functions( ).    "Set function bar visibility
  lo_func->set_all( abap_true ).

  DATA: lo_header  TYPE REF TO cl_salv_form_layout_grid,
        lo_h_label TYPE REF TO cl_salv_form_label,
        lo_h_flow  TYPE REF TO cl_salv_form_layout_flow.

  CREATE OBJECT lo_header.

  lo_h_label = lo_header->create_label( row = 1 column = 1 ). "Create a header area
  lo_h_label->set_text( value = 'Title First Line' ). "Add text to header area
  lo_h_flow = lo_header->create_flow( row = 2 column = 1 ).
  lo_h_flow->create_text(
    EXPORTING
      text     = 'Title Second Line'
  ).
  go_salv->set_top_of_list( value = lo_header ).

  go_salv->set_screen_popup( "Show Alv as pop up
    EXPORTING
      start_column = 10
      end_column   = 75
      start_line   = 5
      end_line     = 25
  ).

  go_salv->display( ).