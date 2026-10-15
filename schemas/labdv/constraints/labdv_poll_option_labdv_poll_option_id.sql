-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_poll_option labdv_poll_option_id
-- Type: CONSTRAINT

-- Name: labdv_poll_option labdv_poll_option_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_poll_option
    ADD CONSTRAINT labdv_poll_option_id PRIMARY KEY (poll_option_id);


--
