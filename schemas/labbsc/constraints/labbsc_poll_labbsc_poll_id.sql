-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_poll labbsc_poll_id
-- Type: CONSTRAINT

-- Name: labbsc_poll labbsc_poll_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_poll
    ADD CONSTRAINT labbsc_poll_id PRIMARY KEY (poll_id);


--
