-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labtri_contact scom_contact_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
