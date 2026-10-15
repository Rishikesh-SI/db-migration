-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_poll_option labpkl_poll_option_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_poll_option labpkl_poll_option_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_poll_option
    ADD CONSTRAINT labpkl_poll_option_id PRIMARY KEY (poll_option_id);


--
