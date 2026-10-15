-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_poll_option labbsc_poll_option_id
-- Type: CONSTRAINT

-- Name: labbsc_poll_option labbsc_poll_option_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_poll_option
    ADD CONSTRAINT labbsc_poll_option_id PRIMARY KEY (poll_option_id);


--
