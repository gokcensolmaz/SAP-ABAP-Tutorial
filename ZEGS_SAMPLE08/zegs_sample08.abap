*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE08
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample08.

DATA: gv_name    TYPE char20,
      gv_surname TYPE char30,
      gv_age     TYPE num4.


START-OF-SELECTION.
  CALL SCREEN 0100.


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.

  LOOP AT SCREEN.
    IF screen-name EQ 'GV_NAME'.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.
    IF screen-name EQ 'GV_SURNAME'.
      screen-invisible = 1.
      MODIFY SCREEN.
    ENDIF.
    IF screen-name EQ 'GV_AGE'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.