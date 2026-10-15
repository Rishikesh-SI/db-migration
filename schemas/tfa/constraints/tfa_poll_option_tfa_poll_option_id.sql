-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_poll_option tfa_poll_option_id
-- Type: CONSTRAINT

-- Name: tfa_poll_option tfa_poll_option_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_poll_option
    ADD CONSTRAINT tfa_poll_option_id PRIMARY KEY (poll_option_id);


--
