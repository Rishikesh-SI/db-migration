-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_poll_option mum_poll_option_id
-- Type: CONSTRAINT

-- Name: dhm_poll_option mum_poll_option_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_poll_option
    ADD CONSTRAINT mum_poll_option_id PRIMARY KEY (poll_option_id);


--
