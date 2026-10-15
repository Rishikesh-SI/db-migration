-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_poll_option tcs_poll_option_id
-- Type: CONSTRAINT

-- Name: tcs_poll_option tcs_poll_option_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_poll_option
    ADD CONSTRAINT tcs_poll_option_id PRIMARY KEY (poll_option_id);


--
