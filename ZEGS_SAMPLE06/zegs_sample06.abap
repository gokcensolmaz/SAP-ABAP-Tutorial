*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE06
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample06.

DATA: gv_name  TYPE char20,
      gv_sname TYPE char20.

DATA: gv_rad1 TYPE char1,
      gv_rad2 TYPE char1.

DATA: gv_checkbox TYPE xfeld.

DATA: gv_text TYPE string.

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
      IF gv_rad1 EQ abap_true. " == IF gv_rad1 eq 'X'.
        gv_text = 'Gender is Male'.
      ELSE.
        gv_text = 'Gender is Female'.
      ENDIF.
      IF gv_checkbox = abap_true.
        CONCATENATE gv_text
                    'Checkbox signed.'
                    INTO gv_text SEPARATED BY space.
      ELSE.
        CONCATENATE gv_text
                    'Checkbox not signed.'
                    INTO gv_text SEPARATED BY space.
      ENDIF.
      MESSAGE gv_text TYPE 'I'.

      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.