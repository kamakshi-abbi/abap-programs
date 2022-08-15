"Code to return first reoccuring character in a string.
" input 'ABCDAB' -> A, input 'ABCDBEE' -> B
TYPES: BEGIN OF CHAR_COUNT_TY,
CHAR TYPE C,
COUNT TYPE I,
END OF CHAR_COUNT_TY.

DATA: CHAR_COUNT TYPE HASHED TABLE OF CHAR_COUNT_TY WITH UNIQUE KEY CHAR,
CHAR_COUNT_STRUCT TYPE CHAR_COUNT_TY,
RESULT TYPE C.

PARAMETERS: STRING TYPE STRING.

PERFORM CHAR_REC USING STRING
CHANGING RESULT.
WRITE: / 'First reoccuring character is', RESULT.

FORM CHAR_REC USING FSTRING
CHANGING FRESULT.
data: i type i,
c type c.
WHILE I < STRLEN( FSTRING ).
C = FSTRING+I(1).
READ TABLE CHAR_COUNT TRANSPORTING NO FIELDS WITH TABLE KEY CHAR = C.
IF SY-SUBRC <> 0.
CHAR_COUNT_STRUCT-CHAR = FSTRING+I(1).
CHAR_COUNT_STRUCT-COUNT = 1.
INSERT CHAR_COUNT_STRUCT INTO TABLE CHAR_COUNT.
ELSE.
FRESULT = FSTRING+I(1).
RETURN.
ENDIF.
i = i + 1.
ENDWHILE.
ENDFORM.

