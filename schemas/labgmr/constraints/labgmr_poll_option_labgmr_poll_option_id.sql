-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_poll_option labgmr_poll_option_id
-- Type: CONSTRAINT

-- Name: labgmr_poll_option labgmr_poll_option_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_poll_option
    ADD CONSTRAINT labgmr_poll_option_id PRIMARY KEY (poll_option_id);


--
