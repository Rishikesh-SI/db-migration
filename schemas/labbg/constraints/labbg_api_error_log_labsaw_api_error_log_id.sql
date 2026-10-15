-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labbg_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labbg; Owner: -
--

ALTER TABLE ONLY labbg.labbg_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
