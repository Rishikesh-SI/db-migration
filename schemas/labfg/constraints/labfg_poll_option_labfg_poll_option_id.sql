-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_poll_option labfg_poll_option_id
-- Type: CONSTRAINT

-- Name: labfg_poll_option labfg_poll_option_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_poll_option
    ADD CONSTRAINT labfg_poll_option_id PRIMARY KEY (poll_option_id);


--
