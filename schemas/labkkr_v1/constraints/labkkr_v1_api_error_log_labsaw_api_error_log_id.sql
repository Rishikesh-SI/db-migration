-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labkkr_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labkkr_v1; Owner: -
--

ALTER TABLE ONLY labkkr_v1.labkkr_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
