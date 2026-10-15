-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_poll_option labstmp_poll_option_id
-- Type: CONSTRAINT

-- Name: labstmp_poll_option labstmp_poll_option_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_poll_option
    ADD CONSTRAINT labstmp_poll_option_id PRIMARY KEY (poll_option_id);


--
