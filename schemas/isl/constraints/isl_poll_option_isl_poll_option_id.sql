-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_poll_option isl_poll_option_id
-- Type: CONSTRAINT

-- Name: isl_poll_option isl_poll_option_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_poll_option
    ADD CONSTRAINT isl_poll_option_id PRIMARY KEY (poll_option_id);


--
