-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_poll_response gsf_poll_response_id
-- Type: CONSTRAINT

-- Name: gsf_poll_response gsf_poll_response_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_poll_response
    ADD CONSTRAINT gsf_poll_response_id PRIMARY KEY (poll_response_id);


--
