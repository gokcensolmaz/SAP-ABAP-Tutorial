*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE11
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample11.

INCLUDE zegs_sample11_top.
INCLUDE zegs_sample11_frm.

START-OF-SELECTION.

PERFORM get_data.
PERFORM set_fieldcat.
PERFORM set_layout.
PERFORM display_alv.