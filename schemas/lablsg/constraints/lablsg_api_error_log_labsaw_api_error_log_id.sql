-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: lablsg_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
