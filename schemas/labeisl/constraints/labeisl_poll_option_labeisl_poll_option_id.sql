-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_poll_option labeisl_poll_option_id
-- Type: CONSTRAINT

-- Name: labeisl_poll_option labeisl_poll_option_id; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_poll_option
    ADD CONSTRAINT labeisl_poll_option_id PRIMARY KEY (poll_option_id);


--
