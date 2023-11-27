*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE06
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample06.
DATA: gv_perid      TYPE i VALUE 5,
      gv_name       TYPE char30,
      gv_sname      TYPE char30,
      gv_bdate      TYPE datum, " se11 - dictionary I used SRM_F4_DATUM
      gv_age        TYPE num2,
      gv_department TYPE char20.

DATA: gv_rad1 TYPE char1,
      gv_rad2 TYPE char1.

DATA: gv_checkbox TYPE xfeld.

DATA: gv_id     TYPE i,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value.

DATA: gv_text  TYPE string,
      gv_index TYPE i.

DATA: gs_personnel   TYPE zegs_smp5_pers_t,
      lv_max_pers_id TYPE i.

DATA: ok_code TYPE sy-ucomm.


START-OF-SELECTION.

  cl_reca_ddic_doma=>get_values( EXPORTING id_name   = 'ZEGS_SMP5_PERSDEPARTMENT_DOM'
                                 IMPORTING et_values = DATA(lt_rsdomaval) ).



  CALL SCREEN 0100.


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
*  SET TITLEBAR 'xxx'.


  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'GV_DEPARTMENT'
      values = VALUE vrm_values( FOR dvalue IN lt_rsdomaval ( key  = dvalue-domvalue_l
                                                            text = dvalue-ddtext ) ).
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

*  CASE sy-ucomm.
  CASE ok_code.
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

    WHEN '&CLEAR'.
      PERFORM clear_data.

    WHEN '&SAVE'.
      PERFORM save_data.
      PERFORM clear_data.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  CLEAR_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM clear_data .
  CLEAR: gv_name,
             gv_sname,
             gv_age,
             gv_checkbox,
             gv_bdate,
             gv_department,
             gv_rad2.
  gv_rad1 = 'X'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SAVE_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save_data .
  gs_personnel-pers_id = gv_perid.
  gs_personnel-pers_name = gv_name.
  gs_personnel-pers_surname = gv_sname.
  gs_personnel-pers_birthdate = gv_bdate.

  CALL FUNCTION 'HRCM_TIME_PERIOD_CALCULATE'
    EXPORTING
      begda         = gv_bdate
      endda         = sy-datum
    IMPORTING
      noyrs         = gv_age
*     nomns         = months
*     nodys         = days
    EXCEPTIONS
      invalid_dates = 1
      overflow      = 2
      OTHERS        = 3.

  gs_personnel-pers_age = gv_age.
  gs_personnel-pers_department = gv_department.
  IF gv_rad1 EQ abap_true.
    gs_personnel-pers_gender = 'M'.
  ELSE.
    gs_personnel-pers_gender = 'F'.
  ENDIF.
  IF gv_checkbox = abap_true.
    gs_personnel-pers_approve = 'X'.
  ENDIF.

  INSERT zegs_smp5_pers_t FROM  gs_personnel.
  COMMIT WORK AND WAIT.

  gv_perid = gv_perid + 1.
ENDFORM.