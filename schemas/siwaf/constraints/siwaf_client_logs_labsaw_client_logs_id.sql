-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_logs labsaw_client_logs_id
-- Type: CONSTRAINT

-- Name: siwaf_client_logs labsaw_client_logs_id; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_client_logs
    ADD CONSTRAINT labsaw_client_logs_id PRIMARY KEY (api_error_log_id);


--
