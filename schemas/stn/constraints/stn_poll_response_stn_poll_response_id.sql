-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_poll_response stn_poll_response_id
-- Type: CONSTRAINT

-- Name: stn_poll_response stn_poll_response_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_poll_response
    ADD CONSTRAINT stn_poll_response_id PRIMARY KEY (poll_response_id);


--
