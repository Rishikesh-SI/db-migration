-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labw88_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labw88; Owner: -
--

ALTER TABLE ONLY labw88.labw88_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
