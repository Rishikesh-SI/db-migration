-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_poll_option labsm_poll_option_id
-- Type: CONSTRAINT

-- Name: labsm_poll_option labsm_poll_option_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_poll_option
    ADD CONSTRAINT labsm_poll_option_id PRIMARY KEY (poll_option_id);


--
