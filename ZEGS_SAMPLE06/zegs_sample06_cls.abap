*&---------------------------------------------------------------------*
*&  Include           ZEGS_SAMPLE06_CLS
*&---------------------------------------------------------------------*

*&-----------------------------Local Class-----------------------------*
CLASS math_op DEFINITION.
    PUBLIC SECTION.
      DATA: lv_num1   TYPE i,
            lv_num2   TYPE i,
            lv_result TYPE i.
  
      METHODS:addition.
    PROTECTED SECTION.
      DATA: lv_protected TYPE i.
    PRIVATE SECTION.
      DATA: lv_private TYPE i.
  ENDCLASS.
  
  CLASS math_op IMPLEMENTATION.
    METHOD addition.
      lv_result = lv_num1 + lv_num2.
    ENDMETHOD.
  ENDCLASS.
  
  *&----------------------------Alt Class--------------------------------*
  
  CLASS math_op_diff DEFINITION INHERITING FROM math_op.
    PUBLIC SECTION.
      METHODS: subtraction.
  ENDCLASS.
  
  CLASS math_op_diff IMPLEMENTATION.
    METHOD subtraction.
      lv_result = lv_num1 - lv_num2.
    ENDMETHOD.
  ENDCLASS.