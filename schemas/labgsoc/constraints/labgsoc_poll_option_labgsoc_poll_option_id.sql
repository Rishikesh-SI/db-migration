-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_poll_option labgsoc_poll_option_id
-- Type: CONSTRAINT

-- Name: labgsoc_poll_option labgsoc_poll_option_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_poll_option
    ADD CONSTRAINT labgsoc_poll_option_id PRIMARY KEY (poll_option_id);


--
