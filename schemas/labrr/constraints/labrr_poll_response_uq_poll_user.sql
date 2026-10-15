-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_poll_response uq_poll_user
-- Type: CONSTRAINT

-- Name: labrr_poll_response uq_poll_user; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_poll_response
    ADD CONSTRAINT uq_poll_user UNIQUE (poll_id, poll_response_guid);


--
