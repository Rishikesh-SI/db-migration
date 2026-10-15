-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_contact unique_constraint
-- Type: CONSTRAINT

-- Name: labrr_contact unique_constraint; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_contact
    ADD CONSTRAINT unique_constraint UNIQUE (unique_id);


--
