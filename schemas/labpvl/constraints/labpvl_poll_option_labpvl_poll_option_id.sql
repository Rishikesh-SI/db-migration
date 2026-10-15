-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_poll_option labpvl_poll_option_id
-- Type: CONSTRAINT

-- Name: labpvl_poll_option labpvl_poll_option_id; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_poll_option
    ADD CONSTRAINT labpvl_poll_option_id PRIMARY KEY (poll_option_id);


--
