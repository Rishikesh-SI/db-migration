-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_poll_response ppb_poll_response_id
-- Type: CONSTRAINT

-- Name: ppb_poll_response ppb_poll_response_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_poll_response
    ADD CONSTRAINT ppb_poll_response_id PRIMARY KEY (poll_response_id);


--
