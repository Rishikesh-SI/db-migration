-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labfih_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labfih; Owner: -
--

ALTER TABLE ONLY labfih.labfih_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
