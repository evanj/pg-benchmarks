# Postgres Benchmarks

This is a collection of quick-and-dirty benchmarks of Postgres that I wrote while investigating the performance of "schemaless" types (HSTORE, JSON, JSONB), and variable-length substring matching with BYTEA and TEXT. I wrote two blog posts about them:

* [Postgres large JSON value query performance](https://www.evanjones.ca/postgres-large-json-performance.html)
* TODO: Write the other blog post


## Running the benchmarks

The `.sql` files contain the scripts I used to run the benchmarks. I ran each one like:

```
psql --file=perf_hstore.sql 'postgresql://postgres@/?host=...' | tee perf_hstore.sql.out
```

The `.out` files contain the raw output from running the tests.

I also wrote `generate_payloads.py` to help me generate the appropriate payloads. The output from that was unfortunately heavily edited, so it may not be directly useful.



## Raw results

I also copy/pasted the results into a Google Sheet:
https://docs.google.com/spreadsheets/d/1WVQuxnZbQrUfg0MWQ7TtDag0sx7to1j4xMik2E11yIQ/edit?usp=sharing


Hstore inline uncompressed
* 10 k/v pairs, 96 byte key, 96 byte value = 1920 data bytes
* column size 2008
* tuple size 2032
* table pages 250000
* pg_total_relation_size 2048598016 | 1954 MB
* select found: 595 ms
* select not found: 554 ms
* count found: 588
* count not found: 553

Hstore inline compressed
* 10 k/v pairs, 96 byte key, 96 byte value + 1 byte = 1921 data bytes
* column size 200
* tuple size 224
* table pages 28572
* pg_total_relation_size 234160128 | 223 MB
* select found: 1120.415
* select not found: 1098.878
* count found: 1116.332
* count not found: 1080.118

Hstore toast uncompressed
* 10 k/v pairs, 96 byte key, 96 byte value + 1 byte = 1921 data bytes
* column size 2005
* tuple size 2033
* table pages: 6370
* toast pages: 333334
* toast tuples: 2000000 (2 toast tuples per value)
* pg_total_relation_size: 2828615680 | 2698 MB
* select found: 3494
* select not found: 3438
* count found: 3537
* count not found: 3437

Hstore toast compressed
* smallest compressed toast: constructed by hand to be compressed, but just too large to be stored inline
* 10 k/v pairs, 96 byte key, 7 with 193 byte values, 1 with 103 byte value, 1 with 96 byte value, 1 with 97 byte value = 2607 data bytes
* column size 2006
* tuple size 2034
* table pages: 6370
* toast pages: 333334
* toast tuples: 2000000 (2 toast tuples per value)
* pg_total_relation_size: 2828615680 | 2698 MB
* select found: 7569
* select not found: 7442
* count found: 7544
* count not found: 7454



Text inline uncompressed
* 2004 data bytes
* column size 2008
* tuple size 2032
* table pages 250000
* toast pages 0
* pg_total_relation_size 2048598016 | 1954 MB
* select v: 268 ms
* select count(v): 289 ms
* count() where not null: 411 ms
* count() length > 100: 433 ms
* count() length > 10000: 291 ms
* count() not found like: 3218
* count() found at end like: 3090
* count() not found regexp: 11697
* count() found at end regexp: 12442
* count() not found position: 1562
* count() found at end position: 5621

Text inline compressed
* 2005 data bytes
* column size 44
* tuple size 68
* table pages 17680
* toast pages 0
* pg_total_relation_size 76619776 | 73 MB
* select v: 115 ms
* select count(v):
* count() where not null query: 179 ms
* count() length > 100 query: 183 ms
* count() length > 10000 query: 87 ms
* count() not found like: 2831
* count() found at end like: 2919
* count() not found regexp: 11476
* count() found at end regexp: 12128
* count() not found position: 3569
* count() found at end position: 5631

Text toast uncompressed
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* select v: 117 ms
* select count(v):
* count() where not null query: 169 ms
* count() length > 100 query: 175 ms
* count() length > 10000 query: 82 ms
* count() not found like: 6002
* count() found at end like: 6069
* count() not found regexp: 14574
* count() found at end regexp: 15719
* count() not found position: 4371
* count() found at end position: 8574

Text toast compressed
* Data bytes 2766
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* select v: 125 ms
* select count(v):
* count() where not null query: 178 ms
* count() length > 100 query: 184 ms
* count() length > 10000 query: 90 ms
* count() not found like: 10681
* count() found at end like: 10463
* count() not found regexp: 22663
* count() found at end regexp: 23359
* count() not found position: 9547
* count() found at end position: 14327


Bytea inline uncompressed
* 2004 data bytes
* column size 2008
* tuple size 2032
* table pages 250000
* toast pages 0
* pg_total_relation_size 2048598016 | 1954 MB
* select v: 237
* select count(v): 260 ms
* count() where not null: 352 ms
* count() length > 100: 351 ms
* count() length > 10000: 251 ms
* count() not found like: 2317
* count() found at end like: 2176
* count() not found position: 2092
* count() found at end position: 2067

Bytea inline compressed
* 2005 data bytes
* column size 44
* tuple size 68
* table pages 17680
* toast pages 0
* pg_total_relation_size 76619776 | 73 MB
* select v: 115 ms
* select count(v):
* count() where not null query: 173 ms
* count() length > 100 query: 176 ms
* count() length > 10000 query: 86 ms
* count() not found like: 1714
* count() found at end like: 1803
* count() not found position: 1798
* count() found at end position: 1897

Bytea toast uncompressed
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* select v: 115 ms
* select count(v):
* count() where not null query: 176 ms
* count() length > 100 query: 178 ms
* count() length > 10000 query: 85 ms
* count() not found like: 5077
* count() found at end like: 5095
* count() not found position: 4933
* count() found at end position: 5010

Bytea toast compressed
* Data bytes 2766
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* select v: 114 ms
* select count(v):
* count() where not null query: 183 ms
* count() length > 100 query: 178 ms
* count() length > 10000 query: 86 ms
* count() not found like: 9207
* count() found at end like: 8959
* count() not found position: 9088
* count() found at end position: 9038


JSON inline uncompressed
* 10 k/v pairs; 96 byte key, 98 byte value + 3 = 1943 data bytes
* column size 2008
* tuple size 2032
* table pages 250000
* toast pages 0
* pg_total_relation_size 2048598016 | 1954 MB
* count found first: 10868
* count found last: 10815
* count not found: 10797

JSON inline compressed
* 10 k/v pairs; 96 byte key, 98 byte value + 4 = 1944 data bytes
* column size 144
* tuple size 168
* table pages 21277
* toast pages 0
* pg_total_relation_size 174383104 | 166 MB
* count found first: 11785
* count found last: 11794
* count not found: 11795

JSON toast uncompressed
* 10 k/v pairs; 96 byte key, 98 byte value + 4 = 1944 data bytes
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* count found first: 14156
* count found last: 14220
* count not found: 14011

JSON toast compressed
* 10 k/v pairs, 96 byte key, 187 byte value + 2 = 2832 data bytes
* column size 2005
* tuple size 2033
* table pages 6370
* toast pages 333334
* pg_total_relation_size 2828615680 | 2698 MB
* count found first: 22337
* count found last: 22197
* count not found: 22318


JSONB inline uncompressed
* 10 k/v pairs, 96 byte key 96 byte value = 1920 data bytes
* column size 2008
* tuple size 2032
* table pages 250000
* toast pages 0
* pg_total_relation_size 2048598016 | 1954 MB
* count found first ->: 976
* count found first ->>: 875
* count found last ->: 856
* count not found ->: 746
* In general ->> is slightly faster than ->
* timing varies substantially between keys: from 770 to 650 ms

JSONB inline compressed
* 10 k/v pairs, 96 byte key, 96 byte value + 1 = 1921 data bytes
* column size 117
* tuple size 141
* table pages 250000
* toast pages 0
* pg_total_relation_size 149020672 | 142 MB
* count found first ->: 1334
* count found last ->: 1337
* count not found ->: 1178

JSONB toast uncompressed
* 10 k/v pairs, 96 byte key, 96 byte value + 1 = 1921 data bytes
* column size 2005
* tuple size 2033
* table pages 250000
* toast pages 0
* pg_total_relation_size 2828615680 | 2698 MB
* count found first ->: 3590
* count found last ->: 3533
* count not found ->: 3393

JSONB toast compressed
* 10 k/v pairs; 96 byte keys, 172 byte values + 1 = 2681 data bytes
* column size 144
* tuple size 168
* table pages 250000
* toast pages 0
* pg_total_relation_size 2828615680 | 2698 MB
* count found first ->: 7615
* count found last ->: 7624
* count not found ->: 7624
