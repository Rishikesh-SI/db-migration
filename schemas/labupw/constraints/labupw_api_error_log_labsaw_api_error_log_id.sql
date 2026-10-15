-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labupw_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
