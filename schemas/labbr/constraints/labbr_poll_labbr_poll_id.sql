-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_poll labbr_poll_id
-- Type: CONSTRAINT

-- Name: labbr_poll labbr_poll_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_poll
    ADD CONSTRAINT labbr_poll_id PRIMARY KEY (poll_id);


--
