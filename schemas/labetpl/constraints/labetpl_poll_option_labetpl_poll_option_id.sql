-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_poll_option labetpl_poll_option_id
-- Type: CONSTRAINT

-- Name: labetpl_poll_option labetpl_poll_option_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_poll_option
    ADD CONSTRAINT labetpl_poll_option_id PRIMARY KEY (poll_option_id);


--
