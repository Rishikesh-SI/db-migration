-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labpvl_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
