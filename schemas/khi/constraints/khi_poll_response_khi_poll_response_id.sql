-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_poll_response khi_poll_response_id
-- Type: CONSTRAINT

-- Name: khi_poll_response khi_poll_response_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_poll_response
    ADD CONSTRAINT khi_poll_response_id PRIMARY KEY (poll_response_id);


--
