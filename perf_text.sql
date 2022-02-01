SET max_parallel_workers_per_gather = 0;

-- 2004 data bytes
CREATE TABLE text_inline_uncompressed (v TEXT NOT NULL);
INSERT INTO text_inline_uncompressed (SELECT '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' FROM generate_series(1, 1000000));
VACUUM ANALYZE text_inline_uncompressed;
SELECT substr(v, 0, 30), octet_length(v), pg_column_size(v), pg_column_size(text_inline_uncompressed) FROM text_inline_uncompressed LIMIT 1;

SELECT 'text_inline_uncompressed';
EXPLAIN ANALYZE SELECT v FROM text_inline_uncompressed;
EXPLAIN ANALYZE SELECT v FROM text_inline_uncompressed;
EXPLAIN ANALYZE SELECT v FROM text_inline_uncompressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v IS NOT NULL;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 100;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE OCTET_LENGTH(v) > 10000;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%notmatch%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%YRdCjpd1%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%YRdCjpd1%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v LIKE '%YRdCjpd1%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'notmatch';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'YRdCjpd1';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'YRdCjpd1';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE v ~ 'YRdCjpd1';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('notmatch' in v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('notmatch' in v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('notmatch' in v) > 0;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('YRdCjpd1' in v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('YRdCjpd1' in v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_uncompressed WHERE position('YRdCjpd1' in v) > 0;

-- 2005 data bytes
CREATE TABLE text_inline_compressed (v TEXT NOT NULL);
INSERT INTO text_inline_compressed (SELECT 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaendxxend' FROM generate_series(1, 1000000));
VACUUM ANALYZE text_inline_compressed;
SELECT substr(v, 0, 30), octet_length(v), pg_column_size(v), pg_column_size(text_inline_compressed) FROM text_inline_compressed LIMIT 1;

SELECT 'text_inline_compressed';
EXPLAIN ANALYZE SELECT v FROM text_inline_compressed;
EXPLAIN ANALYZE SELECT v FROM text_inline_compressed;
EXPLAIN ANALYZE SELECT v FROM text_inline_compressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v IS NOT NULL;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 100;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE OCTET_LENGTH(v) > 10000;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%notmatch%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%endxxend%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%endxxend%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v LIKE '%endxxend%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'notmatch';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'endxxend';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'endxxend';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE v ~ 'endxxend';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('notmatch' IN v) > 0;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('endxxend' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('endxxend' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_inline_compressed WHERE position('endxxend' IN v) > 0;


CREATE TABLE text_toast_uncompressed (v TEXT NOT NULL);
INSERT INTO text_toast_uncompressed (SELECT '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' FROM generate_series(1, 1000000));
VACUUM ANALYZE text_toast_uncompressed;
SELECT substr(v, 0, 30), octet_length(v), pg_column_size(v), pg_column_size(text_toast_uncompressed) FROM text_toast_uncompressed LIMIT 1;

SELECT 'text_toast_uncompressed';
EXPLAIN ANALYZE SELECT v FROM text_toast_uncompressed;
EXPLAIN ANALYZE SELECT v FROM text_toast_uncompressed;
EXPLAIN ANALYZE SELECT v FROM text_toast_uncompressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v IS NOT NULL;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 100;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE OCTET_LENGTH(v) > 10000;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%notmatch%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%RdCjpd18%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%RdCjpd18%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v LIKE '%RdCjpd18%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'notmatch';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'RdCjpd18';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'RdCjpd18';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE v ~ 'RdCjpd18';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('notmatch' IN v) > 0;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('RdCjpd18' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('RdCjpd18' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_uncompressed WHERE position('RdCjpd18' IN v) > 0;


CREATE TABLE text_toast_compressed (v TEXT NOT NULL);
INSERT INTO text_toast_compressed (SELECT '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' FROM generate_series(1, 1000000));
VACUUM ANALYZE text_toast_compressed;
SELECT substr(v, 0, 30), octet_length(v), pg_column_size(v), pg_column_size(text_toast_compressed) FROM text_toast_compressed LIMIT 1;

SELECT 'text_toast_compressed';
EXPLAIN ANALYZE SELECT v FROM text_toast_compressed;
EXPLAIN ANALYZE SELECT v FROM text_toast_compressed;
EXPLAIN ANALYZE SELECT v FROM text_toast_compressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v IS NOT NULL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v IS NOT NULL;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 100;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 100;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 10000;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE OCTET_LENGTH(v) > 10000;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%notmatch%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%notmatch%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%e1jVO5Vr%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%e1jVO5Vr%';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v LIKE '%e1jVO5Vr%';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'notmatch';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'notmatch';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'e1jVO5Vr';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'e1jVO5Vr';
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE v ~ 'e1jVO5Vr';

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('notmatch' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('notmatch' IN v) > 0;

EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('e1jVO5Vr' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('e1jVO5Vr' IN v) > 0;
EXPLAIN ANALYZE SELECT COUNT(*) FROM text_toast_compressed WHERE position('e1jVO5Vr' IN v) > 0;


-- total table size stats
SELECT pg1.oid, pg1.relname, pg1.reltoastrelid, pg1.relpages, pg1.reltuples, pg2.relpages AS toast_pages, pg2.reltuples AS toast_tuples, pg_total_relation_size(pg1.relname::text) AS total_relation_size, pg_size_pretty(pg_total_relation_size(pg1.relname::text)) AS total_relation_size_pretty
FROM pg_class AS pg1, pg_class AS pg2
WHERE pg1.relname NOT LIKE 'pg_%' AND pg1.relname NOT LIKE 'sql_%' and pg1.reltoastrelid = pg2.oid
ORDER BY relname;
