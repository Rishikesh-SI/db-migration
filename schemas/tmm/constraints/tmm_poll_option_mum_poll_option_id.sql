-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_poll_option mum_poll_option_id
-- Type: CONSTRAINT

-- Name: tmm_poll_option mum_poll_option_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_poll_option
    ADD CONSTRAINT mum_poll_option_id PRIMARY KEY (poll_option_id);


--
