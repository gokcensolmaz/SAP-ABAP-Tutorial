*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE18_FRM
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


*------------ICON FOR ALL LINES-------------------
*    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*      <gfs_scarr>-status = '@01@'.
*    ENDLOOP.

*&---------------------------CELL COLOR---------------------------------*
*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    CASE <gfs_scarr>-currcode.
*      WHEN 'USD'.
*        <gfs_scarr>-line_color = 'C710'.
*      WHEN 'JPY'.
*        <gfs_scarr>-line_color = 'C601'.
*      WHEN 'EUR'.
*        CLEAR: gs_cell_color.
*        gs_cell_color-fname  = 'URL'.
*        gs_cell_color-color-col = '3'.
*        gs_cell_color-color-int = '1'.
*        gs_cell_color-color-inv = '0'.
*
*        append gs_cell_color to <gfs_scarr>-cell_color.
*    ENDCASE.
*  ENDLOOP.
*&---------------------------CELL COLOR---------------------------------

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
*&-----------------FULL SCREEN CONTAINER-------------------------------*
*  CREATE OBJECT go_alv
*    EXPORTING
*      i_parent = cl_gui_container=>screen0.
*&-----------------FULL SCREEN CONTAINER-------------------------------*

  IF go_alv IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.

    PERFORM set_dropdown.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.

*--------------When pressed enter handle edit-----------------*
*  CALL METHOD go_alv->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter.

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  ELSE.
    CALL METHOD go_alv->refresh_table_display.
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
FORM set_fcat .
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'STATUS'.
  gs_fcat-scrtext_s = 'Status'.
  gs_fcat-scrtext_m = 'Airline Status'.
  gs_fcat-scrtext_l = 'Airline Company Status'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-scrtext_s = 'Airline ID'.
  gs_fcat-scrtext_m = 'Airline Comp. ID'.
  gs_fcat-scrtext_l = 'Airline Company ID'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CARRNAME'.
  gs_fcat-scrtext_s = 'Airline N'.
  gs_fcat-scrtext_m = 'Airline Comp. Name'.
  gs_fcat-scrtext_l = 'Airline Company Name'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CURRCODE'.
  gs_fcat-scrtext_s = 'Airline CR'.
  gs_fcat-scrtext_m = 'Airline Currency'.
  gs_fcat-scrtext_l = 'Airline Company National Currency'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'URL'.
  gs_fcat-scrtext_s = 'Airl. URL'.
  gs_fcat-scrtext_m = 'Airline URL'.
  gs_fcat-scrtext_l = 'Airline Company URL'.
*  gs_fcat-hotspot = abap_true.
  APPEND gs_fcat TO gt_fcat.

*&----------------Add Dropdown Column----------------------------------*
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'LOCATION'.
  gs_fcat-scrtext_s = 'Location'.
  gs_fcat-scrtext_m = 'Location'.
  gs_fcat-scrtext_l = 'Location'.
  gs_fcat-edit      = abap_true.
  gs_fcat-drdn_hndl = 1.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'COST'.
  gs_fcat-scrtext_s = 'Cost'.
  gs_fcat-scrtext_m = 'Airline Cost'.
  gs_fcat-scrtext_l = 'Airline Company Cost'.
  gs_fcat-edit = abap_true.
  APPEND gs_fcat TO gt_fcat.
*&------------------FIELD CATALOG MERGE--------------------------------*
*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name = 'ZEGS_SMP18_S_SCARR'
**     I_INTERNAL_TABNAME           =
*    CHANGING
*      ct_fieldcat      = gt_fcat.
*
*
*  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH  KEY fieldname = 'MESSAGE'.
*  IF sy-subrc EQ 0.
*    <gfs_fc>-edit = abap_true.
*    <gfs_fc>-no_out = abap_true.
*  ENDIF.
*&------------------FIELD CATALOG MERGE--------------------------------*

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
*&---------------------------CELL COLOR--------------------------------*
*  gs_layout-info_fname = 'LINE_COLOR'.
*  gs_layout-ctab_fname = 'CELL_COLOR'.
*&---------------------------CELL COLOR--------------------------------*
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_TOTAL_SUM
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_total_sum .
  DATA: lv_sum     TYPE int4,
        lv_lines   TYPE int4,
        lv_average TYPE int4.

  LOOP AT gt_scarr INTO gs_scarr.
    lv_sum = lv_sum + gs_scarr-cost.
  ENDLOOP.

  DESCRIBE TABLE gt_scarr LINES lv_lines.

  lv_average = lv_sum / lv_lines.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.

    IF <gfs_scarr>-cost GT lv_average.
      <gfs_scarr>-status = '@0A@'.
    ELSEIF <gfs_scarr>-cost LT lv_average.
      <gfs_scarr>-status = '@08@'.
    ELSE.
      <gfs_scarr>-status = '@09@'.
    ENDIF.
  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_DROPDOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Domestic'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'International'.
  APPEND ls_dropdown TO lt_dropdown.

  go_alv->set_drop_down_table(
    EXPORTING
      it_drop_down       = lt_dropdown
  ).
ENDFORM.