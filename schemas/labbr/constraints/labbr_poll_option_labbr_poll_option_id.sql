-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_poll_option labbr_poll_option_id
-- Type: CONSTRAINT

-- Name: labbr_poll_option labbr_poll_option_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_poll_option
    ADD CONSTRAINT labbr_poll_option_id PRIMARY KEY (poll_option_id);


--
