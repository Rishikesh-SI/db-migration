-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_poll_response msl_poll_response_id
-- Type: CONSTRAINT

-- Name: msl_poll_response msl_poll_response_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_poll_response
    ADD CONSTRAINT msl_poll_response_id PRIMARY KEY (poll_response_id);


--
