-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labspz_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labspz_v1; Owner: -
--

ALTER TABLE ONLY labspz_v1.labspz_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
