*&---------------------------------------------------------------------*
*& Report ZAULA01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaula01.

DATA: frase2 TYPE string,
      val1   TYPE i,
      val2   TYPE i,
      result TYPE i.
PARAMETER: p_frase TYPE string.

CLASS zaula01_teste DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS: teste_find_value FOR TESTING,
      teste_conta FOR TESTING.

ENDCLASS.

START-OF-SELECTION.

  PERFORM find_value CHANGING frase2.

  PERFORM conta USING val1 val2
                CHANGING result.

END-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Form FIND_VALUE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM find_value CHANGING frase2.


  SPLIT p_frase AT ';' INTO DATA(vl_frase1) DATA(vl_frase2).

  frase2 = vl_frase2.

ENDFORM.
CLASS zaula01_teste IMPLEMENTATION.
  METHOD teste_find_value.

    DATA: frase2_teste TYPE string.
    p_frase = 'E ai ;vc usa ponto e vírgula?'.
    PERFORM find_value CHANGING frase2_teste.

    cl_abap_unit_assert=>assert_equals( act = frase2_teste
                                        exp = 'vc usa ponto e vírgula?'
                                        msg = 'Valor não encontrado' ).

  ENDMETHOD.

  METHOD teste_conta.
    DATA:vl1       TYPE i,
         vl2       TYPE i,
         vl_result TYPE i.

    vl1 = 2.
    vl2 = 5.

    PERFORM conta USING vl1 vl2
                  CHANGING vl_result.

    cl_abap_unit_assert=>assert_equals( act = vl_result
                                        exp = 5
                                        msg = 'Valor é diferente').

  ENDMETHOD.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Form CONTA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> VAL1
*&      --> VAL2
*&      <-- RESULT
*&---------------------------------------------------------------------*
FORM conta  USING    p_val1
                     p_val2
            CHANGING p_result.

  p_result = p_val1 * p_val2.

  p_result = p_result / 2.



ENDFORM.
