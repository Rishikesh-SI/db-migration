-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_poll_response labiis_poll_response_id
-- Type: CONSTRAINT

-- Name: labiis_poll_response labiis_poll_response_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_poll_response
    ADD CONSTRAINT labiis_poll_response_id PRIMARY KEY (poll_response_id);


--
