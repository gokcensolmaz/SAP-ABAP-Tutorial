*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample04.

INCLUDE zegs_sample04_top.
INCLUDE zegs_sample04_frm.


START-OF-SELECTION.

  cl_reca_ddic_doma=>get_values( EXPORTING id_name = 'ZEGS_SMP5_PERSDEPARTMENT_DOM'
                                 IMPORTING et_values = DATA(lt_rsdomaval) ).

  CALL SCREEN 0100.



*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR 'New Personnel Record'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'GV_DEPARTMENT'
      values = VALUE vrm_values( FOR dvalue IN lt_rsdomaval ( key  = dvalue-domvalue_l
                                                            text = dvalue-ddtext ) ).

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
    WHEN '&CLR'.
      PERFORM clear_data.
    WHEN '&SAVE'.
      PERFORM save_data.
      PERFORM clear_data.
    WHEN '&SHOW'.
      PERFORM set_fieldcat.
      PERFORM set_layout.
      PERFORM display_alv.
  ENDCASE.
ENDMODULE.