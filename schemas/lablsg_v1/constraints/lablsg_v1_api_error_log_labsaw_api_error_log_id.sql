-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: lablsg_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: lablsg_v1; Owner: -
--

ALTER TABLE ONLY lablsg_v1.lablsg_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
