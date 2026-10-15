-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_poll_option labrao_poll_option_id
-- Type: CONSTRAINT

-- Name: labrao_poll_option labrao_poll_option_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_poll_option
    ADD CONSTRAINT labrao_poll_option_id PRIMARY KEY (poll_option_id);


--
