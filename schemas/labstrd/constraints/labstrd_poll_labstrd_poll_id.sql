-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_poll labstrd_poll_id
-- Type: CONSTRAINT

-- Name: labstrd_poll labstrd_poll_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_poll
    ADD CONSTRAINT labstrd_poll_id PRIMARY KEY (poll_id);


--
