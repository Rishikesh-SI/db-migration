-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labwpl_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
