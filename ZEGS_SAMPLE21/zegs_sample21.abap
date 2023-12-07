*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE21
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample21.


INCLUDE zegs_sample21_top.
INCLUDE zegs_sample21_cls.
INCLUDE zegs_sample21_pbo.
INCLUDE zegs_sample21_pai.
INCLUDE zegs_sample21_frm.



START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.