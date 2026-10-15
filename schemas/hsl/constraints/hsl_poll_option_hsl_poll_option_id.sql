-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_poll_option hsl_poll_option_id
-- Type: CONSTRAINT

-- Name: hsl_poll_option hsl_poll_option_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_poll_option
    ADD CONSTRAINT hsl_poll_option_id PRIMARY KEY (poll_option_id);


--
