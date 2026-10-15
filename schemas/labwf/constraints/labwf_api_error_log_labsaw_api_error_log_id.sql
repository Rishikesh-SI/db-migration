-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labwf_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
