-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_poll_option labpkl_poll_option_id
-- Type: CONSTRAINT

-- Name: labpkl_poll_option labpkl_poll_option_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_poll_option
    ADD CONSTRAINT labpkl_poll_option_id PRIMARY KEY (poll_option_id);


--
