-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_poll_option labman_poll_option_id
-- Type: CONSTRAINT

-- Name: labman_poll_option labman_poll_option_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_poll_option
    ADD CONSTRAINT labman_poll_option_id PRIMARY KEY (poll_option_id);


--
