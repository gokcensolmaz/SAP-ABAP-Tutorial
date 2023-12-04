*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE18
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample18.

INCLUDE zegs_sample18_top.
INCLUDE zegs_sample18_pbo.
INCLUDE zegs_sample18_pai.
INCLUDE zegs_sample18_frm.

DATA: gs_scarr TYPE scarr.

START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN 0100.