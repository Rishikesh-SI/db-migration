-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_poll_option lablsg_poll_option_id
-- Type: CONSTRAINT

-- Name: lablsg_poll_option lablsg_poll_option_id; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_poll_option
    ADD CONSTRAINT lablsg_poll_option_id PRIMARY KEY (poll_option_id);


--
