-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_poll_option labgrl_poll_option_id
-- Type: CONSTRAINT

-- Name: labgrl_poll_option labgrl_poll_option_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_poll_option
    ADD CONSTRAINT labgrl_poll_option_id PRIMARY KEY (poll_option_id);


--
