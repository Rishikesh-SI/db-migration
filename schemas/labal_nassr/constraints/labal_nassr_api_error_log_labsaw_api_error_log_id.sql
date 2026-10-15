-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labal_nassr_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labal_nassr; Owner: -
--

ALTER TABLE ONLY labal_nassr.labal_nassr_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
