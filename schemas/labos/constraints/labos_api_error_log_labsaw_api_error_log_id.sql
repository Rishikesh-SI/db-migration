-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labos_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
