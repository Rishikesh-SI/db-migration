-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labisl_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
