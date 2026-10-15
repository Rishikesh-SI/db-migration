-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_poll labstmp_poll_id
-- Type: CONSTRAINT

-- Name: labstmp_poll labstmp_poll_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_poll
    ADD CONSTRAINT labstmp_poll_id PRIMARY KEY (poll_id);


--
