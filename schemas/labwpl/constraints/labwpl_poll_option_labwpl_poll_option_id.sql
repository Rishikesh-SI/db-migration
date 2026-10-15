-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_poll_option labwpl_poll_option_id
-- Type: CONSTRAINT

-- Name: labwpl_poll_option labwpl_poll_option_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_poll_option
    ADD CONSTRAINT labwpl_poll_option_id PRIMARY KEY (poll_option_id);


--
