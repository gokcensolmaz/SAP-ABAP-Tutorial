*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE21_CLS
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.

    METHODS handle_top_of_page FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING
        e_dyndoc_id
        table_index.

    METHODS handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        e_row_id
        e_column_id.

    METHODS handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        e_row
        e_column
        es_row_no.

    METHODS handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_onf4 FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        e_fieldname
        e_fieldvalue
        es_row_no
        er_event_data
        et_bad_cells
        e_display.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS cl_event_receiver IMPLEMENTATION.

  METHOD handle_top_of_page.

    DATA: lv_text TYPE sdydo_text_element.

    lv_text = 'FLIGHT DETAILS'.

    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu->new_line.

    CLEAR: lv_text.

    CONCATENATE 'User: ' sy-uname INTO lv_text SEPARATED BY space.

    CALL METHOD go_docu->add_text
      EXPORTING
        text         = lv_text
        sap_color    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>medium.

    CALL METHOD go_docu->display_document
      EXPORTING
        parent = go_sub1.

  ENDMETHOD.

  METHOD handle_hotspot_click.
    DATA: lv_mess TYPE char200.

    READ TABLE gt_scarr INTO gs_scarr INDEX e_row_id-index.
    IF sy-subrc EQ 0.
      CASE e_column_id.
        WHEN 'CARRID'.
          CONCATENATE 'Column: '
                      e_column_id-fieldname
                      'with value: '
                      gs_scarr-carrid
                      INTO lv_mess
                        SEPARATED BY space.

          MESSAGE lv_mess TYPE 'I'.
        WHEN 'CARRNAME'.
          CONCATENATE 'Column: '
                      e_column_id-fieldname
                      'with value: '
                      gs_scarr-carrname
                      INTO lv_mess
                        SEPARATED BY space.

          MESSAGE lv_mess TYPE 'I'.
      ENDCASE.
    ENDIF.
  ENDMETHOD.

  METHOD handle_double_click.
    DATA: lv_mess TYPE char200.
    READ TABLE gt_scarr INTO gs_scarr INDEX e_row-index.
    IF sy-subrc EQ 0.
      CONCATENATE 'Column: '
                   e_column-fieldname
                   'with value: '
                   gs_scarr
                   INTO lv_mess
                       SEPARATED BY space.

      MESSAGE lv_mess TYPE 'I'.
    ENDIF.
  ENDMETHOD.

  METHOD handle_data_changed.
    DATA: ls_modi TYPE lvc_s_modi,
          lv_mess TYPE char200.
    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_scarr INTO gs_scarr INDEX ls_modi-row_id.
      IF sy-subrc EQ 0.

      ENDIF.
      CONCATENATE ls_modi-fieldname
                  '=> old value:'
                  gs_scarr-carrname
                  ', new value:'
                  ls_modi-value
                  INTO lv_mess
                  SEPARATED BY space.
      MESSAGE lv_mess TYPE 'I'.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_onf4.
    BREAK-POINT.
  ENDMETHOD.
ENDCLASS.