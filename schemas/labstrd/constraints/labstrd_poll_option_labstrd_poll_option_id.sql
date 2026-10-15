-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_poll_option labstrd_poll_option_id
-- Type: CONSTRAINT

-- Name: labstrd_poll_option labstrd_poll_option_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_poll_option
    ADD CONSTRAINT labstrd_poll_option_id PRIMARY KEY (poll_option_id);


--
