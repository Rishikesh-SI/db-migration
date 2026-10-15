-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgg_contact scom_contact_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
