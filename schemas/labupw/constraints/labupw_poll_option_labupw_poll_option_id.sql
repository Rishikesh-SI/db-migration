-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_poll_option labupw_poll_option_id
-- Type: CONSTRAINT

-- Name: labupw_poll_option labupw_poll_option_id; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_poll_option
    ADD CONSTRAINT labupw_poll_option_id PRIMARY KEY (poll_option_id);


--
