-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_round_video_duration(text)
-- Type: FUNCTION

-- Name: labmsg_round_video_duration(text); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_round_video_duration(p_duration text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_parts text[];
    v_total_seconds numeric;
    v_mins numeric;
BEGIN
    IF p_duration IS NULL OR p_duration = '' THEN
        RETURN NULL;
    END IF;

    v_parts := string_to_array(p_duration, ':');

    IF array_length(v_parts,1) = 2 THEN
        v_total_seconds := (v_parts[1]::numeric * 60) + v_parts[2]::numeric;
    ELSIF array_length(v_parts,1) = 3 THEN
        v_total_seconds := (v_parts[1]::numeric * 3600) + (v_parts[2]::numeric * 60) + v_parts[3]::numeric;
    ELSE
        RETURN p_duration;
    END IF;

    v_mins := CEILING(v_total_seconds / 60.0);

    RETURN v_mins::text;

EXCEPTION WHEN OTHERS THEN
    RETURN p_duration;
END;
$$;


--
