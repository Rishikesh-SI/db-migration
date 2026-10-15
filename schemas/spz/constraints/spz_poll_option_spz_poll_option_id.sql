-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_poll_option spz_poll_option_id
-- Type: CONSTRAINT

-- Name: spz_poll_option spz_poll_option_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_poll_option
    ADD CONSTRAINT spz_poll_option_id PRIMARY KEY (poll_option_id);


--
