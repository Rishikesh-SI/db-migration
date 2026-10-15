-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labsaw_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labsaw; Owner: -
--

ALTER TABLE ONLY labsaw.labsaw_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
