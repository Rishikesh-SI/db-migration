-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_poll_response tcs_poll_response_id
-- Type: CONSTRAINT

-- Name: tcs_poll_response tcs_poll_response_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_poll_response
    ADD CONSTRAINT tcs_poll_response_id PRIMARY KEY (poll_response_id);


--
