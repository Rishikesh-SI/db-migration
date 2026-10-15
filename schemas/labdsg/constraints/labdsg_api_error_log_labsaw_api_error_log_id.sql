-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labdsg_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
