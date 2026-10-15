-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_poll_option labets_poll_option_id
-- Type: CONSTRAINT

-- Name: labets_poll_option labets_poll_option_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_poll_option
    ADD CONSTRAINT labets_poll_option_id PRIMARY KEY (poll_option_id);


--
