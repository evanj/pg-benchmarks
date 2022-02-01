SET max_parallel_workers_per_gather = 0;

-- 10 k/v pairs, 96 byte key 96 byte value = 1920 data bytes
CREATE TABLE jsonb_inline_uncompressed (v JSONB NOT NULL);
INSERT INTO jsonb_inline_uncompressed (SELECT '{"ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY":"pQpORORa0wgFkixLn2OKZvYdbLBu57OmJiSkTlqtcICmpGi79MTAdVgR7kCOZNLlxeRWmc6dUbu9GkvADIXw5F3BS8Ox40mo","ktdVpIchzbe5zIwb5SDWkyphv5NMEgyKzT9aSxhRRtIJxU9mWyeXWdlI5HCE6wikVrmGorXp14QGi84PWTGKBaXp2hkF4EB7":"7NZUabn97bDCeFxT8skyD2uwXSIEAxoXvWbAnvAIXsdTcxa5G4pYiuSVMTPR96EPYXzWA1dna5BJ5o5GmG0H1Uw9B7Wxwnlm","AyhtYr9BHaMd58sGlQqs2aS5wMLMvyWXUaXK83erL8MZiHy59sVVO6HmDYzetQqj4CauQ7DGP1c9drY66udqZstsSCGD8gAu":"yv8nRP8zRflF6jf12fyFbTFFS9iaAe7euT8nZqYy2awpGNif0JaZSMWUx0mmiJrAFU1kXfaLeiV0C94FUSpFrmQ6cvCGoEQM","0jnOfY08PgEEBYaDFxmuTfV1YGmjoInDXJ0A5u35uE4ue5sMnBntW7EBnfTyHgeFKFUdBR919zoPqhQNYiwhUZ129fvncgxI":"dAx4Fv3Bs1SS0XY3I12WRTkQ2TOfn8WO46Vlo7lqTiTtbCbQuJljKDdkzawNcIPKBpVQC7tQAUeXRpiNNTxmNe5BbX7PldJu","JYtvQsWzUX2G6iRfQuHFK6mcQqqW3l1U0mEQqj06NUbv3cKhtthoYtkA0asRREs5VUy07GDAjIgmkLIoRivpeIasvhWAViW6":"Yy5WpWrvxoz72wgDoNEBHGpuvUnOGi3T2Dpk2tkXUF0vqVBrSid6eMkRV7cIKASTK0ipRUSGUiRtgfoOdHguTdud3ESZyD5H","qaQD9na1jkbgK95biBkm9HUwM0pdQV2tOe0HeJ0ZK2NZ2xVUDGDQOKbRG224PNWWPvGBlZSJ6cPPdrweduXZ1JaVOVdZAsKJ":"eldwkp0ufHMm1s36HQAfgy4DYilO0qfLmvJBEu4QVWAbwbYrek4pzIn8gZo9bxJlIubwgjYDZmFnUrAqlheG0FMltn3AJ3e8","2sD0TbE6H3TpcbkZ62oDv09UOuEkmtvwZLMAsex5D9sGF4KNQsby0kKbrwTy6T70d3YwRkJ0CE4vQ2K4DHUv1fS28gRHRuiK":"HcwXWlP7v6Mkwbzw4IpGfvXb6jyhYbJdSF27fHBPYXVjpLkTpeSpOEefPIpl9Yu3blDGyu67kFNZe3xukf58nRmp4JvJidtX","VqRTAm1eMrU3drnUPykvGYRx0eKWPnb4sTZayVFynXnppOyEJ9CoxPSoNbZiH1TIcqH5d8HuPpLjT4xwpm6bxNVQDfu4J2S2":"YtCsRrQAYOW9M3LTV5tYXCGrHlTRmbOwHyQdhPAED6XRaazKoTdVrG85UX2uaXJRy0PqxEpd2nGp7nngV38yPTQ7p8TEFf5X","YKWz58wyoqENn2uM62qqCUXNuzvLn8V2S8mimUL733f99tVT4UsBeZnwVHnQqdTC0jkiEPFlyXh16W71zr89OtuzKatipazj":"zM20ZO5YuzBQ6LFMMfNYBgVW8HWAZNWYPZ0Zi19xsnqpKbfoIpyfJZZv4qWru8VtcNoK3TNYu16jSMdznLXNx7ehi195vaeC","AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX":"z66sxH4SvgtzzO8uSXWZqUZOUjbulnBtTgTuNADEu6aFlw2GwZHCZ1cfjkSfJBIOKdeIosFms7KQrGxpLXeri8p0DXxtjsA7"}' FROM generate_series(1, 1000000));
VACUUM ANALYZE jsonb_inline_uncompressed;
SELECT substr(v::text, 0, 30), octet_length(v::text), pg_column_size(v), pg_column_size(jsonb_inline_uncompressed) FROM jsonb_inline_uncompressed LIMIT 1;

-- first and last
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 

EXPLAIN ANALYZE SELECT COUNT(v->>'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->>'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->>'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_inline_uncompressed; 

EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_inline_uncompressed;

-- missing
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_uncompressed;


-- 10 k/v pairs, 96 byte key, 96 byte value + 1 = 1921 data bytes
CREATE TABLE jsonb_inline_compressed (v JSONB NOT NULL);
INSERT INTO jsonb_inline_compressed (SELECT '{"k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0":"v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0v0","k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1":"v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1v1","k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2":"v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2v2","k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3":"v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3","k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4":"v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4v4","k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5":"v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5v5","k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6":"v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6v6","k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7":"v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7v7","k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8":"v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8","k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9":"v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v"}' FROM generate_series(1, 1000000));
SELECT substr(v::text, 0, 30), octet_length(v::text), pg_column_size(v), pg_column_size(jsonb_inline_compressed) FROM jsonb_inline_compressed LIMIT 1;
VACUUM ANALYZE jsonb_inline_compressed;

-- first and last
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed; 

EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_inline_compressed;

-- missing
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_inline_compressed;

-- 10 k/v pairs, 96 byte key, 96 byte value + 1 = 1921 data bytes
CREATE TABLE jsonb_toast_uncompressed (v JSONB NOT NULL);
INSERT INTO jsonb_toast_uncompressed (SELECT '{"ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY":"pQpORORa0wgFkixLn2OKZvYdbLBu57OmJiSkTlqtcICmpGi79MTAdVgR7kCOZNLlxeRWmc6dUbu9GkvADIXw5F3BS8Ox40mo","ktdVpIchzbe5zIwb5SDWkyphv5NMEgyKzT9aSxhRRtIJxU9mWyeXWdlI5HCE6wikVrmGorXp14QGi84PWTGKBaXp2hkF4EB7":"7NZUabn97bDCeFxT8skyD2uwXSIEAxoXvWbAnvAIXsdTcxa5G4pYiuSVMTPR96EPYXzWA1dna5BJ5o5GmG0H1Uw9B7Wxwnlm","AyhtYr9BHaMd58sGlQqs2aS5wMLMvyWXUaXK83erL8MZiHy59sVVO6HmDYzetQqj4CauQ7DGP1c9drY66udqZstsSCGD8gAu":"yv8nRP8zRflF6jf12fyFbTFFS9iaAe7euT8nZqYy2awpGNif0JaZSMWUx0mmiJrAFU1kXfaLeiV0C94FUSpFrmQ6cvCGoEQM","0jnOfY08PgEEBYaDFxmuTfV1YGmjoInDXJ0A5u35uE4ue5sMnBntW7EBnfTyHgeFKFUdBR919zoPqhQNYiwhUZ129fvncgxI":"dAx4Fv3Bs1SS0XY3I12WRTkQ2TOfn8WO46Vlo7lqTiTtbCbQuJljKDdkzawNcIPKBpVQC7tQAUeXRpiNNTxmNe5BbX7PldJu","JYtvQsWzUX2G6iRfQuHFK6mcQqqW3l1U0mEQqj06NUbv3cKhtthoYtkA0asRREs5VUy07GDAjIgmkLIoRivpeIasvhWAViW6":"Yy5WpWrvxoz72wgDoNEBHGpuvUnOGi3T2Dpk2tkXUF0vqVBrSid6eMkRV7cIKASTK0ipRUSGUiRtgfoOdHguTdud3ESZyD5H","qaQD9na1jkbgK95biBkm9HUwM0pdQV2tOe0HeJ0ZK2NZ2xVUDGDQOKbRG224PNWWPvGBlZSJ6cPPdrweduXZ1JaVOVdZAsKJ":"eldwkp0ufHMm1s36HQAfgy4DYilO0qfLmvJBEu4QVWAbwbYrek4pzIn8gZo9bxJlIubwgjYDZmFnUrAqlheG0FMltn3AJ3e8","2sD0TbE6H3TpcbkZ62oDv09UOuEkmtvwZLMAsex5D9sGF4KNQsby0kKbrwTy6T70d3YwRkJ0CE4vQ2K4DHUv1fS28gRHRuiK":"HcwXWlP7v6Mkwbzw4IpGfvXb6jyhYbJdSF27fHBPYXVjpLkTpeSpOEefPIpl9Yu3blDGyu67kFNZe3xukf58nRmp4JvJidtX","VqRTAm1eMrU3drnUPykvGYRx0eKWPnb4sTZayVFynXnppOyEJ9CoxPSoNbZiH1TIcqH5d8HuPpLjT4xwpm6bxNVQDfu4J2S2":"YtCsRrQAYOW9M3LTV5tYXCGrHlTRmbOwHyQdhPAED6XRaazKoTdVrG85UX2uaXJRy0PqxEpd2nGp7nngV38yPTQ7p8TEFf5X","YKWz58wyoqENn2uM62qqCUXNuzvLn8V2S8mimUL733f99tVT4UsBeZnwVHnQqdTC0jkiEPFlyXh16W71zr89OtuzKatipazj":"zM20ZO5YuzBQ6LFMMfNYBgVW8HWAZNWYPZ0Zi19xsnqpKbfoIpyfJZZv4qWru8VtcNoK3TNYu16jSMdznLXNx7ehi195vaeC","AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX":"z66sxH4SvgtzzO8uSXWZqUZOUjbulnBtTgTuNADEu6aFlw2GwZHCZ1cfjkSfJBIOKdeIosFms7KQrGxpLXeri8p0DXxtjsA7x"}' FROM generate_series(1, 1000000));
SELECT substr(v::text, 0, 30), octet_length(v::text), pg_column_size(v), pg_column_size(jsonb_toast_uncompressed) FROM jsonb_toast_uncompressed LIMIT 1;
VACUUM ANALYZE jsonb_toast_uncompressed;

-- first and last
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_toast_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_toast_uncompressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'ecSGQPJe9HodkyrIcPR3jlUNbrFWqq1QQkUKEQ7tntkaEs0zUSOm2RXeG3XpDvBzTvWU2V8HRGOTPDYqynech97SvEbRfIOY') FROM jsonb_toast_uncompressed; 

EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'AZGGNi0m2rKVYRWouH4L8asZteVeShNNuORzBKZuabqG21XTeqONZ6LfwcpMvOIMhQnYrBHMeAIMjzt4kf6wrBmjvYpO2vlX') FROM jsonb_toast_uncompressed;

-- missing
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_uncompressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_uncompressed;


-- 10 k/v pairs; 96 byte keys, 172 byte values + 1 = 2681 data bytes
CREATE TABLE jsonb_toast_compressed (v JSONB NOT NULL);
INSERT INTO jsonb_toast_compressed (SELECT '{"k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0":"KM0nrNRXjfQtKyAVds3874NkrRraTCRutzFc24W5txwbKn5JhLlNWwptYB3ovjZ5lx5oBjKlD8LvrOofd4fRq4mwYHAPMwN8yx6aIRFkHs5EFCwT0o6fxLnQFJsuMf4VsieqOh2LBMndb9OXloIJd6UYFgDfIiPxJwHDVfcRDDck","k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1k1":"kz3laEiBJ6Gc6UBqfdOrreI4KTQmd3AyRTk569z7mCg9VrMKXr1wihoqjy1Xebonm2gXgDIesc0lkoYMBMGEzsr6wnKQdVo2Ho7Cb7Qi8rVIR3z3zAGRstcNP4w2c5d8cKB7aCoVdjuaBfHKar0vl1fWwro70udGL2MUgWQqxETS","k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2k2":"elQHm9TCC5Ct381Wu7MOw4CS2TfaY4ExuEaWhvgI7LBvsrF3L3YAiN45tDeC8t3olGlmjrdFcwaL6MPHJI2mgYvMMoWxocx2GO1hkV0QIvNc2nGsw0FaPDu0aFCjSRTf7ZP5aVW4tuV2x9kumSoHxUzjIXKfvKi95GjacDdFn5OA","k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3k3":"BlXpJcLaqU9Mv8jqHal6ifgSRQXmf7ywOPdaJMUq3mtxZi77cqPj00wYbEsv32LUGQgbVjUusP94RxeHnqSoRt7Xiw6EKBuShywaUEALQ88UYrUVbY7vQSzrI1zNnMV9s0xCuq5yqRDa9DjQhNYBerkvoOxKCZ18GlrGcXqac8q7","k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4k4":"5xYQtIpsp8Avd8Jq4m7HejhxrR0zGv3gpX8NLduCUhOe0JqxWOdlQGFButKMWG8WoaoKy9JCQQ0eMZTDe0eibHXqJ6txkxk3mTtDri8jIEDkJ1pG9itZcyVGnJXddPq3rLlncbHdWpg0veQlgiFm0z6FVUkKRolUOwX9BGNGYHF7","k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5k5":"sgsf5pvR1EjMDzRMlrCCLXhwl94ohjC5dsZzNoiC79Yf0KlQikrLBcsxbZFMRUltC4YDXm10TXcyj7PNMA2oemgXsQdr7phkt8Qf8y9JedpNJU3UJ51uzDjRtwKLGZm33PY4DHQzL3Tvj7GI9F8AMmosljTraubYMMDTRUBGA9Jj","k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6k6":"TcJiE7YYh7RlrpQn8dAkNgSGvM64zpK0ZuMDZcr9X4aaV816eIxUMH90vo9FsK5ms1jsMSyIpYhKRGCe5KDn4uMQZFrFpJZ8Q3Jsaxoej1Nu47L1WZ0cRTsiHc9okMtRdOqeYWRw6IkoUonAIUqQKVqSFOjQfae3TqX6wQsFjUaf","k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7k7":"7VDAjF1ciKtP3FtClDegrHbFn8R38EDSHDKS0F6VU6oTXewtgFA5BqT44UJKh8PK9TKobVIYxP7lZEGqbmJuPGDXBunIV5DNvxRcrIUb4MA55FpfNJrGhX5yJkof8a9PoB9S1gqU1mx94i9tGTYf4gbPJrvmKmiDqoa24Vg175uO","k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8k8":"egZ8eK5h6nAqQX9AiZGtv2WYQ18eYe2IEke2zuMCsogTlRN35bgphRiXyRRC6vL4LgE94HW78DwcMIfWS1aP4qb4wOQtJNihBTa1kIBVHcFcPjfE2diZT1ZMFD37p6OQURrUQC39uE3Tyn0eJJFNTGdJq4tYfLZ4LCcTWT5Yaqrg","k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9":"IXA1zIYrI7pUSjwayFxQnAihYWAhqfsGdttV7rxbDsYqoeYzqg3ywGOtLi390u2tUo0U9pbTJU0eK9dNOzuFulkg46GY8X0YRpX1NJ723MkosNSlmYfKI200JdbQSJovwiC1RdqQCDRxkwRyX6FBo0te3EwIhpzMhtFe97beGXFRR"}' FROM generate_series(1, 1000000));
SELECT substr(v::text, 0, 30), octet_length(v::text), pg_column_size(v), pg_column_size(jsonb_toast_compressed) FROM jsonb_toast_compressed LIMIT 1;
VACUUM ANALYZE jsonb_toast_compressed;

-- first and last
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed; 
EXPLAIN ANALYZE SELECT COUNT(v->'k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed; 

EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9k9') FROM jsonb_toast_compressed;

-- missing
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed;
EXPLAIN ANALYZE SELECT COUNT(v->'kxk0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0k0') FROM jsonb_toast_compressed;


-- total table size stats
SELECT pg1.oid, pg1.relname, pg1.reltoastrelid, pg1.relpages, pg1.reltuples, pg2.relpages AS toast_pages, pg2.reltuples AS toast_tuples, pg_total_relation_size(pg1.relname::text) AS total_relation_size, pg_size_pretty(pg_total_relation_size(pg1.relname::text)) AS total_relation_size_pretty
FROM pg_class AS pg1, pg_class AS pg2
WHERE pg1.relname NOT LIKE 'pg_%' AND pg1.relname NOT LIKE 'sql_%' and pg1.reltoastrelid = pg2.oid
ORDER BY relname;