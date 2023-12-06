*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE19_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '100'.
  SET TITLEBAR 'New Personnel Record'.

  cl_reca_ddic_doma=>get_values( EXPORTING id_name = 'ZEGS_SMP5_PERSDEPARTMENT_DOM'
                                     IMPORTING et_values = DATA(lt_rsdomaval) ).

*&-------------Dropdown Menu Items------------&
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'GV_DEPARTMENT'
      values = VALUE vrm_values( FOR dvalue IN lt_rsdomaval ( key  = dvalue-domvalue_l
                                                            text = dvalue-ddtext ) ).
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '200'.
  SET TITLEBAR 'PERSONNEL LIST ALV'.

  perform display_alv.
ENDMODULE.