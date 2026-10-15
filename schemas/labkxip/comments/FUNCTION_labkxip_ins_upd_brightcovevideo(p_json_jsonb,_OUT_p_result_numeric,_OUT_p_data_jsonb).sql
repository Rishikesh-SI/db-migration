-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: FUNCTION labkxip_ins_upd_brightcovevideo(p_json jsonb, OUT p_result numeric, OUT p_data jsonb)
-- Type: COMMENT

-- Name: FUNCTION labkxip_ins_upd_brightcovevideo(p_json jsonb, OUT p_result numeric, OUT p_data jsonb); Type: COMMENT; Schema: labkxip; Owner: -
--

COMMENT ON FUNCTION labkxip.labkxip_ins_upd_brightcovevideo(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) IS 'Upserts a Brightcove video record. Inserts on first sync and updates on re-sync.';


--
