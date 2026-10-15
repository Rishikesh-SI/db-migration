-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_poll tfa_poll_id
-- Type: CONSTRAINT

-- Name: tfa_poll tfa_poll_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_poll
    ADD CONSTRAINT tfa_poll_id PRIMARY KEY (poll_id);


--
