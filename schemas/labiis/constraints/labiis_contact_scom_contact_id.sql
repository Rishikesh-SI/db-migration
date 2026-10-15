-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labiis_contact scom_contact_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
