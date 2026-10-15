-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_poll_option labpr_poll_option_id
-- Type: CONSTRAINT

-- Name: labpr_poll_option labpr_poll_option_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_poll_option
    ADD CONSTRAINT labpr_poll_option_id PRIMARY KEY (poll_option_id);


--
