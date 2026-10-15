-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_poll_option hsl_poll_option_id
-- Type: CONSTRAINT

-- Name: labhsl_poll_option hsl_poll_option_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_poll_option
    ADD CONSTRAINT hsl_poll_option_id PRIMARY KEY (poll_option_id);


--
