-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_poll labets_poll_id
-- Type: CONSTRAINT

-- Name: labets_poll labets_poll_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_poll
    ADD CONSTRAINT labets_poll_id PRIMARY KEY (poll_id);


--
