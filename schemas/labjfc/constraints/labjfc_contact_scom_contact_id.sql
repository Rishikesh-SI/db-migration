-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labjfc_contact scom_contact_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
