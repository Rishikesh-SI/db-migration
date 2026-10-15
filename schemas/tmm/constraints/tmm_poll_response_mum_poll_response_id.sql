-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_poll_response mum_poll_response_id
-- Type: CONSTRAINT

-- Name: tmm_poll_response mum_poll_response_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_poll_response
    ADD CONSTRAINT mum_poll_response_id PRIMARY KEY (poll_response_id);


--
