*&---------------------------------------------------------------------*
*& Report  ZEGS_SAMPLE05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zegs_sample05.


*&-----------------------Variables---------------------------------------*

*DATA gv_var1 TYPE p DECIMALS 2. " Floating number with 2 decimal point like 1.23
*DATA gv_var2 TYPE int4.         " Integer number
*DATA gv_var7 TYPE i.            " Also integer
*DATA gv_var3 TYPE n.            " Number with length 1
*DATA gv_var8 TYPE n LENGTH 10.  " Number with length 10
*DATA gv_var4 TYPE c.            " Single Character
*DATA gv_var5 TYPE string.       " String
*DATA gv_var6(6) TYPE c.         " Char array length with 6

* Also can be written as:
DATA: gv_var1    TYPE p DECIMALS 2, " Floating number with 2 decimal point like 1.23
      gv_var2    TYPE int4,         " Integer number
      gv_var7    TYPE i,            " Also integer
      gv_var3    TYPE n,            " Number with length 1
      gv_var8    TYPE n LENGTH 10,  " Number with length 10
      gv_var4    TYPE c,            " Single Character
      gv_var5    TYPE string,       " String
      gv_var6(6) TYPE c.            " Char array length with 6

gv_var1 = '12.54'.
gv_var1 = '3.14'.

gv_var2 = 13.
gv_var2 = 431.

gv_var3 = 623. " it would be 3

gv_var4 = 'A'.
gv_var4 = 'c'.

gv_var5 = 'Any sentences.'.

WRITE: /  'gv_var1 :' &&  gv_var1 ,
       /  'gv_var2 : ' &&  gv_var2 ,
       /  'gv_var3 : ' &&  gv_var3,
       /  'gv_var4 : ' &&  gv_var4 ,
       /  'gv_var5 : ' &&  gv_var5 .

*&-----------------------Math Ops, Loops, Conditions------------------------*

DATA: gv_var01  TYPE i VALUE 20,
      gv_var02  TYPE i VALUE 5,
      gv_result TYPE i,
      gv_text   TYPE string.

gv_text = 'Addition: '.
gv_result = gv_var01 + gv_var02.
WRITE: / gv_text,  gv_result.

gv_text = 'Subtraction: '.
gv_result = gv_var01 - gv_var02.
WRITE: / gv_text,  gv_result.

gv_text = 'Multiplication: '.
gv_result = gv_var01 * gv_var02.
WRITE: / gv_text,  gv_result.

gv_text = 'Division: '.
gv_result = gv_var01 / gv_var02.
WRITE: / gv_text,  gv_result.

* If condition statement :
*
* IF (condition).
*   (Block of Code)
* ELSEIF (condition2).
*   (Block of Code)
* ELSE.
*    (Block of Code)
* ENDIF.

IF gv_var01 > gv_var02.
  WRITE / 'The first variable is greater than the second'.
ELSEIF gv_var01 < gv_var02.
  WRITE / 'The second variable is greater than the first'.
ELSEIF gv_var01 = gv_var02.
  WRITE / 'They are equal'.
ELSE.
  WRITE / 'There is an error'.
ENDIF.

* Case when condition statement:
*
*  CASE (condition) .
*  	WHEN (selection 1).
*      (Block of Code)
*  	WHEN (selection 2).
*      (Block of Code)
*  	WHEN OTHERS.
*      (Block of Code)
*  ENDCASE.

CASE gv_result.
  WHEN 100.
    WRITE / 'There is a multiplication operation'.
  WHEN 4.
    WRITE / 'There is an division operaiton'.
  WHEN OTHERS.
    WRITE / 'Can be addition or subtraction'.
ENDCASE.

* Do loop statement:
*
*  DO (repetition) TIMES.
*      (Block of Code)
*  ENDDO.

gv_var01 = 0.
DO 4 TIMES.
  gv_var01 = gv_var01 + 1.
  WRITE: / gv_var01, 'This will be written to this screen 4 times from do loop'.
ENDDO.


* While loop statement:
*
*  WHILE (condition).
*    (Block of Code)
*  ENDWHILE.

gv_var01 = 0.
WHILE gv_var01 < 2.
  gv_var01 = gv_var01 + 1.
  WRITE: / gv_var01, 'This will be written to this screen 10 times from while loop'.
ENDWHILE.

*  <  LT
*  >  GT
*  =  EQ
*  <= LE
*  >= GE

*&------------------- Table, Data Element & Domain ---------------*

* Create a table with columns:
* Personnel ID | Personnel Name | Personnel Surname | Personnel Gender
*
* Table > Data Element > Domain
*

*&-------------------- Open SQL Komutları ----------------------*

DATA: gv_persid      TYPE zegs_smp5_persid_de,
      gv_persname    TYPE zegs_smp5_persname_de,
      gv_perssurname TYPE zegs_smp5_perssurname_de,
      gv_persgender  TYPE zegs_smp5_persgend_de,
      gs_personnel_t TYPE zegs_smp5_pers_t,
      gt_personnel_t TYPE TABLE OF zegs_smp5_pers_t.

*  SELECT
*  UPDATE
*  INSERT
*  DELETE
*  MODIFY

* Transfer all values from one table to another table
SELECT * FROM zegs_smp5_pers_t
  INTO TABLE gt_personnel_t.

* Keeping a single row (struct) of the table
SELECT * FROM zegs_smp5_pers_t
  INTO gs_personnel_t.
ENDSELECT.

* Keeping a single row (struct) of the table
SELECT SINGLE pers_id FROM zegs_smp5_pers_t
  INTO gv_persid .


* Get certain lines
SELECT * FROM zegs_smp5_pers_t
  INTO TABLE gt_personnel_t
  WHERE pers_gender = 'F'.

* Update data from some rows
UPDATE  zegs_smp5_pers_t
  SET pers_name = 'HAKAN' pers_gender = 'M'
  WHERE pers_id = 1.

* Insert a new row to table
gs_personnel_t-pers_id = 4.
gs_personnel_t-pers_name = 'FATIH'.
gs_personnel_t-pers_surname = 'SOLMAZ'.
gs_personnel_t-pers_gender = 'M'.

INSERT zegs_smp5_pers_t FROM gs_personnel_t.

* Remove some record from table
DELETE FROM zegs_smp5_pers_t WHERE pers_id = 2.

* If the key not exist INSERT; else if key exist and some columns different update
gs_personnel_t-pers_id = 5.
gs_personnel_t-pers_name = 'ELIF GOKCEN'.
gs_personnel_t-pers_surname = 'SOLMAZ'.
gs_personnel_t-pers_gender = 'F'.

MODIFY zegs_smp5_pers_t FROM  gs_personnel_t.


*&-------------------- User Data Inputs ----------------------*

*  PARAMETERS
*  SELECT-OPTIONS
*  CHECKBOX
*  RADIO-BUTTON
*  SELECTION-SCREEN
TABLES : zegs_smp5_pers_t.

* Parameters:
PARAMETERS: p_num1  TYPE int4,
            p_pname TYPE zegs_smp5_persname_de.

* Select-options:
SELECT-OPTIONS: s_psurn FOR gv_perssurname,
s_pgen FOR zegs_smp5_pers_t-pers_gender.

* Checkbox
PARAMETERS: p_cbox1 AS CHECKBOX.

* Selection-screen
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE text-001.
*Radio-button
PARAMETERS: p_radbt1 RADIOBUTTON GROUP gr1,
            p_radbt2 RADIOBUTTON GROUP gr1,
            p_radbt3 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE text-002.

PARAMETERS: p_radbt4 RADIOBUTTON GROUP gr2,
            p_radbt5 RADIOBUTTON GROUP gr2,
            p_radbt6 RADIOBUTTON GROUP gr2.

SELECTION-SCREEN END OF BLOCK bl2.

*&-------------------- Event Blocks, Form, Include ----------------------*

*  INITIALIZATION.
* The code block that is intended to run before the user input parameters entered on the screen
*
*  AT SELECTION-SCREEN.
* Structure used to customize the input parameters used in the screen
*
*  START-OF-SELECTION.
*
*
*  END-OF-SELECTION.

PARAMETERS: p_num TYPE int4.

* Before run it initialize value of num to 12.

INITIALIZATION.
  p_num = 12.

* It increase num by one each time the user press enter
AT SELECTION-SCREEN.
  p_num = p_num + 1.

START-OF-SELECTION.
  PERFORM increase_num_by_2.
  WRITE 'Start of selection'.
  WRITE:/ 'Result is: ', gv_result.

END-OF-SELECTION.
  WRITE 'End of selection'.
  PERFORM multiply_two_numbers USING 5
                                     9.



* FORM
FORM increase_num_by_2.
  gv_result = gv_result + 2.
ENDFORM.

FORM multiply_two_numbers USING p_num2
                                p_num3.
  DATA: lv_result TYPE int4.
  lv_result = p_num2 * p_num3.
  WRITE:/ 'Result is : ', lv_result.
ENDFORM.

*INCLUDE zegs_sample05_top.
*gv_include_num1 = 9.
*
*WRITE :/ 'INCLUDE Number is : ' , gv_include_num1.