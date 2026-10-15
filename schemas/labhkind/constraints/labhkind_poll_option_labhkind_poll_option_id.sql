-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_poll_option labhkind_poll_option_id
-- Type: CONSTRAINT

-- Name: labhkind_poll_option labhkind_poll_option_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_poll_option
    ADD CONSTRAINT labhkind_poll_option_id PRIMARY KEY (poll_option_id);


--
