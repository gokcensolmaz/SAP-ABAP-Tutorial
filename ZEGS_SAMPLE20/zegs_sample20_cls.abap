*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE20_CLS
*&---------------------------------------------------------------------*

CLASS cl_gridhandler DEFINITION.
    PUBLIC SECTION.
      METHODS handle_top_of_page FOR EVENT top_of_page OF cl_gui_alv_grid
        IMPORTING
          e_dyndoc_id
          table_index.
  
      METHODS handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed
                  e_onf4
                  e_onf4_before
                  e_onf4_after
                  e_ucomm.
  
    PROTECTED SECTION.
    PRIVATE SECTION.
  ENDCLASS.
  
  
  CLASS cl_gridhandler IMPLEMENTATION.
  
    METHOD handle_top_of_page.
      DATA: lv_text TYPE sdydo_text_element.
  
      lv_text = 'PERSONNEL DETAILS'.
  
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
  
  
    ENDMETHOD.
  
    METHOD handle_data_changed.
      DATA: ls_modi TYPE lvc_s_modi,
            lv_mess TYPE char200.
      LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
        READ TABLE gt_personnel ASSIGNING <gfs_personnel> INDEX ls_modi-row_id.
  
        IF ls_modi-value < 25.
          <gfs_personnel>-result  = 'FF'.
          PERFORM color_cell USING '6' '1' '0'.
        ELSEIF ls_modi-value < 50.
          <gfs_personnel>-result  = 'DD'.
          PERFORM color_cell USING '7' '1' '0'.
        ELSEIF ls_modi-value < 75.
          <gfs_personnel>-result  = 'CC'.
          PERFORM color_cell USING '3' '1' '0'.
        ELSEIF ls_modi-value < 100.
          <gfs_personnel>-result  = 'BB'.
          PERFORM color_cell USING '3' '0' '0'.
        ELSE.
          <gfs_personnel>-result  = 'AA'.
          PERFORM color_cell USING '5' '1' '0'.
        ENDIF.
        go_alv->refresh_table_display( ).
        CONCATENATE ls_modi-fieldname
                          '=> old value:'
                          gs_personnel-result
                          ', new value:'
                          ls_modi-value
                          INTO lv_mess
                          SEPARATED BY space.
        MESSAGE lv_mess TYPE 'I'.
  
      ENDLOOP.
    ENDMETHOD.
  ENDCLASS.