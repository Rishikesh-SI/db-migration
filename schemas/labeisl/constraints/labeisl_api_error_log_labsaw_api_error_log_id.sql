-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labeisl_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
