-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_page trg_page_set_pattern_alias
-- Type: TRIGGER

-- Name: labfih_page trg_page_set_pattern_alias; Type: TRIGGER; Schema: labfih; Owner: -
--

CREATE TRIGGER trg_page_set_pattern_alias BEFORE INSERT OR UPDATE OF alias ON labfih.labfih_page FOR EACH ROW EXECUTE FUNCTION labfih.labfih_page_set_pattern_alias();


--
