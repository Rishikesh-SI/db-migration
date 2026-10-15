-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labdd_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labdd_v1_30april24; Owner: -
--

ALTER TABLE ONLY labdd_v1_30april24.labdd_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
