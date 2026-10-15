-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: encrypt_text(text)
-- Type: FUNCTION

-- Name: encrypt_text(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.encrypt_text(p_plain_text text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_key bytea;
    v_iv bytea;
    v_plain bytea;
    v_cipher bytea;
BEGIN
    -- 🔹 Decode Base64 keys
    v_key := decode('RDBOQjVDREVYRDdIUTUwWg==', 'base64');
    v_iv  := decode('TjRTTDRTV05HN0ZEOTRSTg==', 'base64');

    -- 🔹 Convert text to UTF-16LE (Encoding.Unicode equivalent)
    v_plain := convert(
                    convert_to(p_plain_text, 'UTF8'),
                    'UTF8',
                    'UTF16LE'
               );

    -- 🔹 Encrypt AES-CBC (PKCS7 default like .NET)
    v_cipher := encrypt_iv(
        v_plain,
        v_key,
        v_iv,
        'aes-cbc'
    );

    -- 🔹 Return Base64
    RETURN encode(v_cipher, 'base64');
END;
$$;


--
