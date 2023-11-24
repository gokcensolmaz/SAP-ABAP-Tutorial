*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE06
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample06.

DATA: gv_name type char20,
      gv_sname type char20.

START-OF-SELECTION.
  CALL SCREEN 0100.


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      MESSAGE gv_name type 'I'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.