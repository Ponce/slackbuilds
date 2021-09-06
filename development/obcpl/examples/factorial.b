GET "LIBHDR"

LET START() = VALOF $(
        FOR I = 1 TO 5 DO
                WRITEF("%N! = %I4*N", I, FACT(I))
        RESULTIS 0
$)

AND FACT(N) = N = 0 -> 1, N * FACT(N - 1)
