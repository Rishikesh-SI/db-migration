-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_poll_option labos_poll_option_id
-- Type: CONSTRAINT

-- Name: labos_poll_option labos_poll_option_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_poll_option
    ADD CONSTRAINT labos_poll_option_id PRIMARY KEY (poll_option_id);


--
