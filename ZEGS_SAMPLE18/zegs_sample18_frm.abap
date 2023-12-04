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
      INTO TABLE gt_scarr.
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
  
  *&--------Fullscreen Container-----------------------------------------*
  *  CREATE OBJECT go_alv
  *    EXPORTING
  *      i_parent = cl_gui_container=>screen0.
  *&---------------------------------------------------------------------*
  
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.
  
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.
  
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        i_structure_name = 'SCARR'
      CHANGING
        it_outtab        = gt_scarr.
  
  ENDFORM.