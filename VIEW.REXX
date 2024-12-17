/* REXX: VIEW - Browse a dataset by KEV */
/* FEEL FREE TO MAKE IT BETTER - I KNOW YOU CAN! :) */

PARSE ARG DATASET
IF DATASET = '' THEN DO
    SAY "USAGE: VIEW dataset_name"
    EXIT 1
END

/* Validate dataset name (optional checks) */
/* e.g., if POS(' ', DATASET) > 0 THEN ... */

ADDRESS TSO
"ALLOCATE FILE(INFILE) DATASET('"DATASET"') SHR REUSE"
IF RC <> 0 THEN DO
    SAY "ERROR: Could not allocate dataset '"DATASET"'. RC="RC
    EXIT RC
END

/* For large datasets, consider reading only partial or providing options */
"EXECIO * DISKR INFILE (STEM INFILE. FINIS"
IF RC <> 0 THEN DO
    SAY "ERROR: Could not read dataset '"DATASET"'. RC="RC
    "FREE FILE(INFILE)"
    EXIT RC
END

IF INFILE.0 = 0 THEN DO
    SAY "NOTE: The dataset '"DATASET"' is empty."
END
ELSE DO
    DO I = 1 TO INFILE.0
        SAY INFILE.I
    END
END

"FREE FILE(INFILE)"
EXIT 0
