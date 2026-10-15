-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_poll_option labrr_poll_option_id
-- Type: CONSTRAINT

-- Name: labrr_poll_option labrr_poll_option_id; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_poll_option
    ADD CONSTRAINT labrr_poll_option_id PRIMARY KEY (poll_option_id);


--
