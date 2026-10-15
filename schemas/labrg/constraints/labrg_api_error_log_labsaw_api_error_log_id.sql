-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labrg_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labrg; Owner: -
--

ALTER TABLE ONLY labrg.labrg_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
