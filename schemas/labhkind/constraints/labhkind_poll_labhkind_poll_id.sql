-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_poll labhkind_poll_id
-- Type: CONSTRAINT

-- Name: labhkind_poll labhkind_poll_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_poll
    ADD CONSTRAINT labhkind_poll_id PRIMARY KEY (poll_id);


--
