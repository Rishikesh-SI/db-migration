-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_poll_option labiis_poll_option_id
-- Type: CONSTRAINT

-- Name: labiis_poll_option labiis_poll_option_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_poll_option
    ADD CONSTRAINT labiis_poll_option_id PRIMARY KEY (poll_option_id);


--
