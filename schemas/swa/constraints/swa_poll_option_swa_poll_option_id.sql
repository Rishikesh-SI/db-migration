-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_poll_option swa_poll_option_id
-- Type: CONSTRAINT

-- Name: swa_poll_option swa_poll_option_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_poll_option
    ADD CONSTRAINT swa_poll_option_id PRIMARY KEY (poll_option_id);


--
