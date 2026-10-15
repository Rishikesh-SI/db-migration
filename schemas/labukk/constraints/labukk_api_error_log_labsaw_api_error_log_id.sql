-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labukk_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labukk; Owner: -
--

ALTER TABLE ONLY labukk.labukk_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
