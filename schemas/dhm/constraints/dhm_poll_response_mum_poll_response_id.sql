-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_poll_response mum_poll_response_id
-- Type: CONSTRAINT

-- Name: dhm_poll_response mum_poll_response_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_poll_response
    ADD CONSTRAINT mum_poll_response_id PRIMARY KEY (poll_response_id);


--
