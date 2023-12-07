*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE21
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample21.


INCLUDE ZEGS_SAMPLE21_TOP.
INCLUDE ZEGS_SAMPLE21_CLS.
INCLUDE ZEGS_SAMPLE21_PBO.
INCLUDE ZEGS_SAMPLE21_PAI.
INCLUDE ZEGS_SAMPLE21_FRM.



START-OF-SELECTION.

  PERFORM get_data.
  perform set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.