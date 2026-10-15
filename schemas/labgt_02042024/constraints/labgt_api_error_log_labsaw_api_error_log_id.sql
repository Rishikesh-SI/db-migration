-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labgt_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labgt_02042024; Owner: -
--

ALTER TABLE ONLY labgt_02042024.labgt_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
