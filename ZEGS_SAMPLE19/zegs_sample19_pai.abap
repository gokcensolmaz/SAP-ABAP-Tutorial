*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE19_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
    WHEN '&CLEAR'.
      PERFORM clear_data.
    WHEN '&SAVE'.
      PERFORM save_data.
      PERFORM clear_data.
    WHEN '&DISPLAY'.
      PERFORM set_fcat.
      PERFORM set_layout.
      PERFORM display_alv.
      CALL screen 200.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
CASE SY-UCOMM.
  WHEN '&BACK'.
    LEAVE TO SCREEN 100.
  WHEN '&SAVE_ALV'.
    PERFORM calculate_status.
ENDCASE.
ENDMODULE.