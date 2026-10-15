-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labrr_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
