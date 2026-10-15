-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_page_set_pattern_alias()
-- Type: FUNCTION

-- Name: labfih_page_set_pattern_alias(); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_page_set_pattern_alias() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
  NEW.is_pattern_alias := (NEW.alias ~ '[\^$.*+?()\[\]{}|\\]');
  RETURN NEW;
END;
$_$;


--
