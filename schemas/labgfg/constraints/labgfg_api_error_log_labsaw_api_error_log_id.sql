-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labgfg_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
