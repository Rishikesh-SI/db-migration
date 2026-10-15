-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_poll mum_poll_id
-- Type: CONSTRAINT

-- Name: dhm_poll mum_poll_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_poll
    ADD CONSTRAINT mum_poll_id PRIMARY KEY (poll_id);


--
