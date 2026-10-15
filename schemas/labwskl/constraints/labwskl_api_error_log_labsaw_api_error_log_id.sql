-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labwskl_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labwskl; Owner: -
--

ALTER TABLE ONLY labwskl.labwskl_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
